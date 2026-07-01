using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authorization;
using OurCompanion.Application.DTOs.Auth;
using OurCompanion.Application.Interfaces.Services;

namespace OurCompanion.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AuthController : ControllerBase
    {
        private readonly IAuthService _authService;

        public AuthController(IAuthService authService)
        {
            _authService = authService;
        }

        [HttpPost("request-otp")]
        [AllowAnonymous]
        public async Task<IActionResult> RequestOtp([FromBody] RequestOtpDto request)
        {
            await _authService.RequestOtpAsync(request);
            return NoContent();
        }

        [HttpPost("verify-otp")]
        [AllowAnonymous]
        public async Task<IActionResult> VerifyOtp([FromBody] VerifyOtpDto request)
        {
            var result = await _authService.VerifyOtpAsync(request);
            return Ok(result); // Automatically returns the JWTs, or "IsRegistrationRequired = true"
        }

        [HttpPost("register")]
        [AllowAnonymous]
        public async Task<IActionResult> Register([FromBody] RegisterUserDto request)
        {
            var result = await _authService.RegisterUserAsync(request);
            return Ok(result);
        }

        [HttpPost("refresh-token")]
        [AllowAnonymous]
        public async Task<IActionResult> RefreshToken([FromBody] RefreshTokenRequestDto request)
        {
            var result = await _authService.RefreshTokenAsync(request.RefreshToken);
            return Ok(result);
        }

        [HttpPost("logout")]
        [AllowAnonymous]
        public async Task<IActionResult> Logout([FromBody] RefreshTokenRequestDto request)
        {
            await _authService.LogoutAsync(request.RefreshToken);
            return NoContent();
        }
    }
}
