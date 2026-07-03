using OurCompanion.Application.DTOs.UserProfile;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OurCompanion.Application.Interfaces.Services
{
    public interface IUserFileService
    {
        Task UploadFileAsync(int accountId, UploadFileDto dto);
        Task<List<UserFileDto>> GetFilesAsync(int accountId);
    }
}
