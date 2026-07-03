using OurCompanion.Application.DTOs.UserProfile;
using OurCompanion.Domain.Enums;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OurCompanion.Application.Interfaces.Services
{
    public interface IAdminService
    {
        Task<List<UserProfileDto>> GetPendingCompanionsAsync();

        Task<List<UserFileDto>> GetCompanionFilesAsync(int userProfileId);

        Task UpdateKycStatusAsync(
            int userProfileId, KycStatus status);

        Task UpdateBgCheckStatusAsync(
            int userProfileId, BgCheckStatus status);
    }
}
