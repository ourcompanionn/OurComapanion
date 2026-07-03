using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OurCompanion.Application.Interfaces.Services
{
    public interface ICloudinaryService
    {
        Task<string> UploadFileAsync(
            Stream fileStream,
            string fileName,
            string contentType);

        Task DeleteFileAsync(string fileUrl);
    }
}
