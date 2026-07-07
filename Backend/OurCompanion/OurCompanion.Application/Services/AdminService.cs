using AutoMapper;
using OurCompanion.Application.Common.Exceptions;
using OurCompanion.Application.DTOs.UserProfile;
using OurCompanion.Application.Interfaces.Repositories;
using OurCompanion.Application.Interfaces.Services;
using OurCompanion.Domain.Enums;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OurCompanion.Application.Services
{
    public class AdminService : IAdminService
    {
        private readonly IUnitOfWork _unitOfWork;
        private readonly IMapper _mapper;

        public AdminService(IUnitOfWork unitOfWork, IMapper mapper)
        {
            _unitOfWork = unitOfWork;
            _mapper = mapper;
        }

        public async Task<List<UserProfileDto>> GetPendingCompanionsAsync()
        {
            var pending = await _unitOfWork.UserProfiles
                .FindAsync(p =>
                    p.IsActive &&
                    (
                        p.KycStatus == (byte)KycStatus.Pending ||
                        p.BgCheckStatus == (byte)BgCheckStatus.Pending
                    ));

            var result = new List<UserProfileDto>();

            foreach (var profile in pending)
            {
                var account = await _unitOfWork.Accounts
                    .GetByIdAsync(profile.AccountId);

                if (account?.AccountType != "Companion") continue;

                var dto = _mapper.Map<UserProfileDto>(profile);
                dto.FirstName = account.FirstName ?? string.Empty;
                dto.LastName = account.LastName ?? string.Empty;
                dto.PhoneNumber = account.PhoneNumber ?? string.Empty;

                result.Add(dto);
            }

            return result;
        }

        public async Task<List<UserFileDto>> GetCompanionFilesAsync(
            int userProfileId)
        {
            var files = await _unitOfWork.UserFiles
                .FindAsync(f => f.UserProfileId == userProfileId);

            return _mapper.Map<List<UserFileDto>>(files);
        }

        public async Task UpdateKycStatusAsync(
            int userProfileId, KycStatus status)
        {
            var profile = await _unitOfWork.UserProfiles
                .GetByIdAsync(userProfileId);

            if (profile == null)
                throw new NotFoundException("Profile not found.");

            profile.KycStatus = (byte)status;
            profile.UpdatedAt = DateTime.UtcNow;

            _unitOfWork.UserProfiles.Update(profile);

            // Verify account only when both checks are approved
            if (profile.KycStatus == (byte)KycStatus.Approved &&
                profile.BgCheckStatus == (byte)BgCheckStatus.Cleared)
            {
                var account = await _unitOfWork.Accounts
                    .GetByIdAsync(profile.AccountId);

                if (account != null)
                {
                    account.IsVerified = true;
                    _unitOfWork.Accounts.Update(account);
                }
            }

            await _unitOfWork.SaveAsync();
        }

        public async Task UpdateBgCheckStatusAsync(
            int userProfileId, BgCheckStatus status)
        {
            var profile = await _unitOfWork.UserProfiles
                .GetByIdAsync(userProfileId);

            if (profile == null)
                throw new NotFoundException("Profile not found.");

            profile.BgCheckStatus = (byte)status;
            profile.UpdatedAt = DateTime.UtcNow;

            _unitOfWork.UserProfiles.Update(profile);

            if (profile.KycStatus == (byte)KycStatus.Approved &&
                profile.BgCheckStatus == (byte)BgCheckStatus.Cleared)
            {
                var account = await _unitOfWork.Accounts
                    .GetByIdAsync(profile.AccountId);

                if (account != null)
                {
                    account.IsVerified = true;
                    _unitOfWork.Accounts.Update(account);
                }
            }
            await _unitOfWork.SaveAsync();
        }
    }
}
