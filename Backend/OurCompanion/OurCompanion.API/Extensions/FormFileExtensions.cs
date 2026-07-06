using OurCompanion.Application.DTOs.UserProfile;
using OurCompanion.Domain.Enums;

namespace OurCompanion.API.Extensions
{
    public static class FormFileExtensions
    {
        public static UploadFileDto ToUploadFileDto(
       this IFormFile file, UserFileType fileType)
        {
            return new UploadFileDto
            {
                FileStream = file.OpenReadStream(),
                FileName = file.FileName,
                ContentType = file.ContentType,
                FileType = fileType
            };
        }
    }
}
