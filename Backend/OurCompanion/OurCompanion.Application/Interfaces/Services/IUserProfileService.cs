using OurCompanion.Application.DTOs.UserProfile;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OurCompanion.Application.Interfaces.Services
{
    public interface IUserProfileService
    {
        Task<UserProfileDto> CreateProfileAsync(
            int accountId, CreateUserProfileDto dto);

        Task<UserProfileDto> GetProfileAsync(int accountId);

        Task UpdateProfileAsync(
            int accountId, UpdateUserProfileDto dto);

        Task UpdateCategoriesAsync(
            int accountId, List<int> categoryIds);

        Task ToggleOnlineStatusAsync(int accountId);

        Task UpdateLocationAsync(
            int accountId, UpdateLocationDto dto);
    }
}
