using CloudinaryDotNet;
using CloudinaryDotNet.Actions;
using Microsoft.Extensions.Options;
using OurCompanion.Application.Common.Models;
using OurCompanion.Application.Interfaces.Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OurCompanion.Infrastructure.Notifications
{
    public class CloudinaryService : ICloudinaryService
    {
        private readonly Cloudinary _cloudinary;

        public CloudinaryService(IOptions<CloudinarySettings> config)
        {
            var account = new Account(
                config.Value.CloudName,
                config.Value.ApiKey,
                config.Value.ApiSecret
            );
            _cloudinary = new Cloudinary(account);
        }

        public async Task<string> UploadFileAsync(
            Stream fileStream,
            string fileName,
            string contentType)
        {
            var isImage = contentType.StartsWith("image/");

            if (isImage)
            {
                var uploadParams = new ImageUploadParams
                {
                    File = new FileDescription(fileName, fileStream),
                    Folder = "ourcompanion/profiles",
                    UseFilename = false,
                    UniqueFilename = true
                };

                Console.WriteLine($"Stream Length: {fileStream.Length}");
                Console.WriteLine($"Stream Position: {fileStream.Position}");

                var result = await _cloudinary.UploadAsync(uploadParams);

                Console.WriteLine($"Cloudinary Bytes: {result.Bytes}");
                Console.WriteLine($"Width: {result.Width}");
                Console.WriteLine($"Height: {result.Height}");
                Console.WriteLine(result.SecureUrl);

                if (result.Error != null)
                    throw new Exception(result.Error.Message);

                return result.SecureUrl.ToString();
            }
            else
            {
                var uploadParams = new RawUploadParams
                {
                    File = new FileDescription(fileName, fileStream),
                    Folder = "ourcompanion/documents",
                    UseFilename = false,
                    UniqueFilename = true
                };

                var result = await _cloudinary.UploadAsync(uploadParams);

                if (result.Error != null)
                    throw new Exception(result.Error.Message);

                return result.SecureUrl.ToString();
            }
        }

        public async Task DeleteFileAsync(string fileUrl)
        {
            var publicId = ExtractPublicId(fileUrl);

            var deleteParams = new DeletionParams(publicId);
            await _cloudinary.DestroyAsync(deleteParams);
        }

        private static string ExtractPublicId(string fileUrl)
        {
            // extract public id from cloudinary url
            // e.g. https://res.cloudinary.com/cloud/image/upload/v123/ourcompanion/profiles/abc.jpg
            // returns ourcompanion/profiles/abc
            var uri = new Uri(fileUrl);
            var segments = uri.AbsolutePath.Split('/');
            var uploadIndex = Array.IndexOf(segments, "upload");
            var publicIdSegments = segments
                .Skip(uploadIndex + 2) // skip version segment
                .ToArray();
            var publicId = string.Join("/", publicIdSegments);
            return Path.ChangeExtension(publicId, null);
        }
    }
}
