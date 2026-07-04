using AutoMapper;
using OurCompanion.Application.Common.Exceptions;
using OurCompanion.Application.DTOs.UserProfile;
using OurCompanion.Application.Interfaces.Repositories;
using OurCompanion.Application.Interfaces.Services;
using OurCompanion.Domain.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OurCompanion.Application.Services
{
    public class UserFileService : IUserFileService
    {
        private readonly IUnitOfWork _unitOfWork;
        private readonly ICloudinaryService _cloudinaryService;
        private readonly IMapper _mapper;

        public UserFileService(
            IUnitOfWork unitOfWork,
            ICloudinaryService cloudinaryService,
            IMapper mapper)
        {
            _unitOfWork = unitOfWork;
            _cloudinaryService = cloudinaryService;
            _mapper = mapper;
        }

        public async Task UploadFileAsync(int accountId, UploadFileDto dto)
        {
            var profile = await _unitOfWork.UserProfiles
                .FindSingleAsync(p => p.AccountId == accountId);

            if (profile == null)
                throw new NotFoundException("Profile not found.");

            // check if file of this type already exists
            var existing = await _unitOfWork.UserFiles
                .FindSingleAsync(f =>
                    f.UserProfileId == profile.Id &&
                    f.FileType == (byte)dto.FileType);

            // upload to cloudinary
            var fileUrl = await _cloudinaryService.UploadFileAsync(
                dto.FileStream,
                dto.FileName,
                dto.ContentType);

            if (existing != null)
            {
                // delete old file from cloudinary
                await _cloudinaryService.DeleteFileAsync(existing.FileUrl);

                // update existing row
                existing.FileUrl = fileUrl;
                existing.UpdatedAt = DateTime.UtcNow;

                _unitOfWork.UserFiles.Update(existing);
            }
            else
            {
                // create new row
                await _unitOfWork.UserFiles.AddAsync(new UserFiles
                {
                    UserProfileId = profile.Id,
                    FileType = (byte)dto.FileType,
                    FileUrl = fileUrl,
                    IsActive = true,
                    CreatedAt = DateTime.UtcNow
                });
            }

            await _unitOfWork.SaveAsync();
        }

        public async Task<List<UserFileDto>> GetFilesAsync(int accountId)
        {
            var profile = await _unitOfWork.UserProfiles
                .FindSingleAsync(p => p.AccountId == accountId);

            if (profile == null)
                throw new NotFoundException("Profile not found.");

            var files = await _unitOfWork.UserFiles
                .FindAsync(f =>
                    f.UserProfileId == profile.Id &&
                    f.IsActive == true);

            return _mapper.Map<List<UserFileDto>>(files);
        }
    }
}
