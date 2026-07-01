using AutoMapper;
using OurCompanion.Application.Common.Exceptions;
using OurCompanion.Application.DTOs.Auth;
using OurCompanion.Application.Interfaces.Repositories;
using OurCompanion.Application.Interfaces.Services;
using OurCompanion.Application.Mappings;
using OurCompanion.Application.DTOs.Account;
using OurCompanion.Domain.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Security.Principal;
using System.Text;
using System.Threading.Tasks;

namespace OurCompanion.Application.Services
{
    public class AuthService : IAuthService
    {
        private readonly IUnitOfWork _unitOfWork;
        private readonly ITokenService _tokenService;
        private readonly INotificationService _notificationService;
        private readonly IMapper _mapper;

        public AuthService(IUnitOfWork unitOfWork,ITokenService tokenService,INotificationService notificationService,IMapper mapper)
        {
            _unitOfWork = unitOfWork;
            _tokenService = tokenService;
            _notificationService = notificationService;
            _mapper = mapper;
        }

        //request otp
        public async Task<bool> RequestOtpAsync(RequestOtpDto request)
        {
            var otpcode = System.Security.Cryptography.RandomNumberGenerator.GetInt32(100000, 900000).ToString();

            var hashotp = HashOtp(otpcode);

            var otpVerification = new OtpVerification
            {
                Identifier = request.PhoneNumber,
                OtpHash = hashotp,
                Purpose = "Authentication",
                AttemptCount = 0,
                IsUsed = false,
                ExpiresAt = DateTime.UtcNow.AddMinutes(5),
                LastUpdatedAt = DateTime.UtcNow
            };

            await _unitOfWork.OtpVerifications.AddAsync(otpVerification);
            await _unitOfWork.SaveAsync();

            await _notificationService.SendOtpAsync(null, request.PhoneNumber, otpcode);
            return true;

        }
        
        public async Task<AuthResult> VerifyOtpAsync(VerifyOtpDto request)
        {
            var hashedOtp=HashOtp(request.OtpCode);

            var otpRecords = await _unitOfWork.OtpVerifications.FindAsync(o =>
            o.Identifier == request.PhoneNumber &&
            o.IsUsed==false &&
            o.ExpiresAt > DateTime.UtcNow);

            var latestOtpRecord = otpRecords.OrderByDescending(o => o.LastUpdatedAt).FirstOrDefault();

            if (latestOtpRecord == null)
            {
                throw new UnauthorizedException("No active OTP found. Please request a new one.");
            }

            // brute force protection, check if they are locked out

            if (latestOtpRecord.AttemptCount >= 5)
            {
                latestOtpRecord.IsUsed = true; // Lock it permanently
                _unitOfWork.OtpVerifications.Update(latestOtpRecord);
                await _unitOfWork.SaveAsync();
                throw new UnauthorizedException("Too many failed attempts. Please request a new OTP.");
            }

            // Check if the hashes actually match
            if (latestOtpRecord.OtpHash != hashedOtp)
            {
                // if it is wrong, increment and save
                latestOtpRecord.AttemptCount += 1;
                latestOtpRecord.LastUpdatedAt = DateTime.UtcNow;
                _unitOfWork.OtpVerifications.Update(latestOtpRecord);
                await _unitOfWork.SaveAsync();

                throw new UnauthorizedException($"Invalid OTP. You have {5 - latestOtpRecord.AttemptCount} attempts remaining.");
            }

            //if it is correct
            latestOtpRecord.IsUsed = true;
            latestOtpRecord.LastUpdatedAt = DateTime.UtcNow;
            _unitOfWork.OtpVerifications.Update(latestOtpRecord);
            await _unitOfWork.SaveAsync();

            // Route the user (Existing User vs New User)
            var existingAccount = await _unitOfWork.Accounts.FindSingleAsync(a => a.PhoneNumber == request.PhoneNumber);

            if (existingAccount != null)
            {
                var accessToken = _tokenService.GenerateAccessToken(existingAccount);
                var refreshToken = _tokenService.GenerateRefreshToken();

                //user session table
                await CreateUserSessionAsync(existingAccount.Id, refreshToken, request.DeviceIdentifier, request.Platform, request.DeviceName);

                return new AuthResult
                {
                    AccessToken = accessToken,
                    RefreshToken = refreshToken,
                    Account = _mapper.Map<AccountDto>(existingAccount)
                };
            }

            return new AuthResult
            {
                IsRegistrationRequired = true,
                AccessToken = null,
                RefreshToken = null,
                Account = null
            };  
        }

        public async Task<AuthResult> RegisterUserAsync(RegisterUserDto request)
        {
            // is phone number successfully verified in the last 15 minutes
            var otpverified = await _unitOfWork.OtpVerifications.FindSingleAsync(o =>
            o.Identifier == request.PhoneNumber &&
            o.IsUsed == true &&
            o.LastUpdatedAt > DateTime.UtcNow.AddMinutes(-15));

            if (otpverified == null)
                throw new UnauthorizedException("Phone number is not verified or verification expired. Please request a new OTP.");

            var account = _mapper.Map<Account>(request);
            account.LastLoginAt = DateTime.UtcNow;
            account.UpdatedAt = DateTime.UtcNow;

            //save new user to database
            await _unitOfWork.Accounts.AddAsync(account);
            await _unitOfWork.SaveAsync();

            ////delete old otp record
            //_unitOfWork.OtpVerifications.Delete(otpverified);
            //await _unitOfWork.SaveAsync();

            var accessToken= _tokenService.GenerateAccessToken(account);
            var refreshToken=_tokenService.GenerateRefreshToken();

            //saving session
            await CreateUserSessionAsync(account.Id, refreshToken, request.DeviceIdentifier, request.Platform, request.DeviceName);

            return new AuthResult
            {
                AccessToken = accessToken,
                RefreshToken = refreshToken,
                Account = _mapper.Map<AccountDto>(account)
            };
        }

        public async Task<AuthResult> RefreshTokenAsync(string refreshToken)
        {
            var session = await _unitOfWork.UserSessions.FindSingleAsync(o => o.RefreshToken == refreshToken);

            if (session == null)
                throw new UnauthorizedException("Invalid refresh token");

            if (session.IsRevoked)
                throw new UnauthorizedException("This session has been revoked. Please log in again.");

            if (session.ExpiresAt < DateTime.UtcNow)
                throw new UnauthorizedException("Refresh token expired. Please log in again.");

            //get user account

            var account=await _unitOfWork.Accounts.GetByIdAsync(session.AccountId);

            if (account == null || !account.IsActive)
                throw new UnauthorizedException("Account is disabled or deleted.");

            // Update old session
            session.IsRevoked = true;
            _unitOfWork.UserSessions.Update(session);

            var newAccessToken = _tokenService.GenerateAccessToken(account);
            var newRefreshToken = _tokenService.GenerateRefreshToken();
            
            // Add the new session directly to memory instead of helper method
            var newSession = new UserSession
            {
                AccountId = account.Id,
                DeviceIdentifier = session.DeviceIdentifier,
                Platform = session.Platform,
                DeviceName = session.DeviceName,
                RefreshToken = newRefreshToken,
                IsRevoked = false,
                ExpiresAt = DateTime.UtcNow.AddDays(7),
                LastUsedAt = DateTime.UtcNow,
                CreatedAt = DateTime.UtcNow
            };
            await _unitOfWork.UserSessions.AddAsync(newSession);

            //cuts roundtrip of database
            await _unitOfWork.SaveAsync();
            return new AuthResult
            {
                AccessToken = newAccessToken,
                RefreshToken = newRefreshToken,
                Account = _mapper.Map<AccountDto>(account)
            };

        }

        public async Task<bool> LogoutAsync(string refreshToken)
        {
            var session = await _unitOfWork.UserSessions.FindSingleAsync(s => s.RefreshToken == refreshToken);

            if (session != null)
            {
                // Kill the session
                session.IsRevoked = true;
                _unitOfWork.UserSessions.Update(session);
                await _unitOfWork.SaveAsync();
            }

            return true;
        }


        // helper method for hashing
        private static string HashOtp(string otp)
        {
            using var sha256 = System.Security.Cryptography.SHA256.Create();
            var bytes = System.Text.Encoding.UTF8.GetBytes(otp);
            var hashBytes = sha256.ComputeHash(bytes);
            return Convert.ToBase64String(hashBytes);
        }
        private async Task CreateUserSessionAsync(int accountId, string refreshToken, string deviceId, string platform, string? deviceName)
        {
            var session = new UserSession
            {
                AccountId = accountId,
                DeviceIdentifier = deviceId,
                Platform = platform,
                DeviceName = deviceName,
                RefreshToken = refreshToken,
                IsRevoked = false,
                ExpiresAt = DateTime.UtcNow.AddDays(7), // Refresh token lives for 7 days
                LastUsedAt = DateTime.UtcNow,
                CreatedAt = DateTime.UtcNow
            };

            await _unitOfWork.UserSessions.AddAsync(session);
            await _unitOfWork.SaveAsync();
        }


    }
}
