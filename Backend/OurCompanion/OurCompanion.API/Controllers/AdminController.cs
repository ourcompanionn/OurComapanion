using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using OurCompanion.Application.Interfaces.Services;
using OurCompanion.Domain.Enums;

namespace OurCompanion.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize(Roles ="Admin")]
    public class AdminController : ControllerBase
    {
        private readonly IAdminService _adminService;

        public AdminController(IAdminService adminService)
        {
            _adminService = adminService;
        }

        // GET /api/admin/companions/pending
        [HttpGet("companions/pending")]
        public async Task<IActionResult> GetPendingCompanions()
        {
            var result = await _adminService.GetPendingCompanionsAsync();
            return Ok(result);
        }

        // GET /api/admin/companions/{userProfileId}/files
        [HttpGet("companions/{userProfileId}/files")]
        public async Task<IActionResult> GetCompanionFiles(int userProfileId)
        {
            var result = await _adminService.GetCompanionFilesAsync(userProfileId);
            return Ok(result);
        }

        // PATCH /api/admin/companions/{userProfileId}/kyc
        [HttpPatch("companions/{userProfileId}/kyc")]
        public async Task<IActionResult> UpdateKycStatus(
            int userProfileId,
            [FromBody] KycStatus status)
        {
            await _adminService.UpdateKycStatusAsync(userProfileId, status);
            return NoContent();
        }

        // PATCH /api/admin/companions/{userProfileId}/bgcheck
        [HttpPatch("companions/{userProfileId}/bgcheck")]
        public async Task<IActionResult> UpdateBgCheckStatus(
            int userProfileId,
            [FromBody] BgCheckStatus status)
        {
            await _adminService.UpdateBgCheckStatusAsync(userProfileId, status);
            return NoContent();
        }
    }
}
