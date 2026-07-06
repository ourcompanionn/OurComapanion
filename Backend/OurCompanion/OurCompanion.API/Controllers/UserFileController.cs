using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using OurCompanion.API.Extensions;
using OurCompanion.Application.Interfaces.Services;
using OurCompanion.Domain.Enums;

namespace OurCompanion.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserFileController : ControllerBase
    {
        private readonly IUserFileService _fileService;

        public UserFileController(IUserFileService fileService)
        {
            _fileService = fileService;
        }

        // POST /api/files
        [HttpPost]
        public async Task<IActionResult> UploadFile(
            IFormFile file,
            [FromQuery] UserFileType fileType)
        {
            Console.WriteLine($"Name: {file.FileName}");
            Console.WriteLine($"Length: {file.Length}");
            Console.WriteLine($"Type: {file.ContentType}");

            await _fileService.UploadFileAsync(
                User.GetAccountId(),
                file.ToUploadFileDto(fileType));
            return Ok("File uploaded successfully.");
        }

        // GET /api/files
        [HttpGet]
        public async Task<IActionResult> GetFiles()
        {
            var result = await _fileService
                .GetFilesAsync(User.GetAccountId());
            return Ok(result);
        }
    }
}
