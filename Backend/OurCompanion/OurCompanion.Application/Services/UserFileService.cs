using AutoMapper;
using OurCompanion.Application.Common.Exceptions;
using OurCompanion.Application.DTOs.UserProfile;
using OurCompanion.Application.Interfaces.Repositories;
using OurCompanion.Application.Interfaces.Services;
using OurCompanion.Domain.Entities;
using OurCompanion.Domain.Enums;
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
            if (dto.FileStream == null || dto.FileStream.Length == 0)
                throw new BadRequestException("No file provided.");

            var profile = await _unitOfWork.UserProfiles
                .FindSingleAsync(p => p.AccountId == accountId);

            if (profile == null)
                throw new NotFoundException("Profile not found.");

            var existing = await _unitOfWork.UserFiles
                .FindSingleAsync(f =>
                    f.UserProfileId == profile.Id &&
                    f.FileType == (byte)dto.FileType);

            var fileUrl = await _cloudinaryService.UploadFileAsync(
                dto.FileStream,
                dto.FileName,
                dto.ContentType);

            if (dto.FileType == UserFileType.KycDocument)
            {
                profile.KycStatus = (byte)KycStatus.Pending;
            }
            else if (dto.FileType == UserFileType.BgCheckDocument)
            {
                profile.BgCheckStatus = (byte)BgCheckStatus.Pending;
            }

            profile.UpdatedAt = DateTime.UtcNow;
            _unitOfWork.UserProfiles.Update(profile);

            if (existing != null)
            {
                await _cloudinaryService.DeleteFileAsync(existing.FileUrl);

                existing.FileUrl = fileUrl;
                existing.UpdatedAt = DateTime.UtcNow;

                _unitOfWork.UserFiles.Update(existing);
            }
            else
            {
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

            // Check if all required files have been uploaded
            var uploadedFiles = await _unitOfWork.UserFiles
                .FindAsync(f => f.UserProfileId == profile.Id && f.IsActive);

            var uploadedTypes = uploadedFiles
                .Select(f => (UserFileType)f.FileType)
                .ToHashSet();

            var hasAllRequiredFiles =
                uploadedTypes.Contains(UserFileType.KycDocument) &&
                uploadedTypes.Contains(UserFileType.PhotoFront) &&
                uploadedTypes.Contains(UserFileType.PhotoLeft) &&
                uploadedTypes.Contains(UserFileType.PhotoRight) &&
                uploadedTypes.Contains(UserFileType.BgCheckDocument);

            if (hasAllRequiredFiles)
            {
                var account = await _unitOfWork.Accounts
                    .GetByIdAsync(accountId);

                if (account != null)
                {
                    account.IsProfileCompleted = true;
                    _unitOfWork.Accounts.Update(account);
                }
                await _unitOfWork.SaveAsync();
            }

            
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
