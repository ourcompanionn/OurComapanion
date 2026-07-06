using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using OurCompanion.API.Extensions;
using OurCompanion.Application.DTOs.UserProfile;
using OurCompanion.Application.Interfaces.Services;

namespace OurCompanion.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserProfileController : ControllerBase
    {
        private readonly IUserProfileService _profileService;

        public UserProfileController(IUserProfileService profileService)
        {
            _profileService = profileService;
        }

        // POST /api/profile
        [HttpPost]
        public async Task<IActionResult> CreateProfile(
            [FromBody] CreateUserProfileDto dto)
        {
            var result = await _profileService
                .CreateProfileAsync(User.GetAccountId(), dto);
            return Ok(result);
        }

        // GET /api/profile
        [HttpGet]
        public async Task<IActionResult> GetProfile()
        {
            var result = await _profileService
                .GetProfileAsync(User.GetAccountId());
            return Ok(result);
        }

        // PATCH /api/profile
        [HttpPatch]
        public async Task<IActionResult> UpdateProfile(
            [FromBody] UpdateUserProfileDto dto)
        {
            await _profileService
                .UpdateProfileAsync(User.GetAccountId(), dto);
            return NoContent();
        }

        // PATCH /api/profile/categories
        [HttpPatch("categories")]
        public async Task<IActionResult> UpdateCategories(
            [FromBody] List<int> categoryIds)
        {
            await _profileService
            .UpdateCategoriesAsync(User.GetAccountId(), categoryIds);
            return NoContent();
        }

        // PATCH /api/profile/online
        [HttpPatch("online")]
        public async Task<IActionResult> ToggleOnline()
        {
            await _profileService
            .ToggleOnlineStatusAsync(User.GetAccountId());
            return NoContent();
        }

        // PATCH /api/profile/location
        [HttpPatch("location")]
        public async Task<IActionResult> UpdateLocation(
            [FromBody] UpdateLocationDto dto)
        {
            await _profileService
            .UpdateLocationAsync(User.GetAccountId(), dto);
            return NoContent();
        }
    }
}
