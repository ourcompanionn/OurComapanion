using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using OurCompanion.Application.DTOs.Auth;

namespace OurCompanion.Application.Interfaces.Services
{
    public interface IAuthService
    {
        Task<bool> RequestOtpAsync(RequestOtpDto request);

        //OTP Verify
        Task<AuthResult> VerifyOtpAsync(VerifyOtpDto request);
        //register
        Task<AuthResult> RegisterUserAsync(RegisterUserDto request);

        //Refreshtoken
        Task<AuthResult> RefreshTokenAsync(string refreshToken);

        //Logout
        Task<bool> LogoutAsync(string refreshToken);
    }
}
