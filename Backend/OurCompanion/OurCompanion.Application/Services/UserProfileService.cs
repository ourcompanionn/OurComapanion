using AutoMapper;
using OurCompanion.Application.Common.Exceptions;
using OurCompanion.Application.DTOs.Category;
using OurCompanion.Application.DTOs.UserProfile;
using OurCompanion.Application.Interfaces.Repositories;
using OurCompanion.Application.Interfaces.Services;
using OurCompanion.Domain.Entities;
using OurCompanion.Domain.Enums;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Principal;
using System.Text;
using System.Threading.Tasks;

namespace OurCompanion.Application.Services
{
    public class UserProfileService : IUserProfileService
    {
        private readonly IUnitOfWork _unitOfWork;
        private readonly IMapper _mapper;
        public UserProfileService(IUnitOfWork unitOfWork, IMapper mapper)
        {
            _unitOfWork = unitOfWork;
            _mapper = mapper;
        }

        private static readonly UserFileType[] RequiredKycFileTypes =
        {
            UserFileType.KycDocument,
            UserFileType.PhotoFront,
            UserFileType.PhotoLeft,
            UserFileType.PhotoRight
        };

        public async Task<UserProfileDto> CreateProfileAsync(
        int accountId, CreateUserProfileDto dto)
        {
            var existing = await _unitOfWork.UserProfiles
                 .FindSingleAsync(p => p.AccountId == accountId);

            if (existing != null)
                throw new AlreadyExistException("Profile already exists.");

            var account = await _unitOfWork.Accounts
                .GetByIdAsync(accountId);

            if (account == null)
                throw new NotFoundException("Account not found.");

            var categories = await _unitOfWork.Categories
                 .FindAsync(c => dto.CategoryIds.Contains(c.Id) && c.IsActive);

            var foundIds = categories
                .Select(c => c.Id)
                .ToHashSet();

            var invalidIds = dto.CategoryIds
                .Where(id => !foundIds.Contains(id))
                .ToList();

            if (invalidIds.Any())
            {
                throw new BadRequestException(
                    $"Invalid or inactive category IDs: {string.Join(", ", invalidIds)}");
            }

            var profile = new UserProfiles
            {
                AccountId = accountId,
                Gender = dto.Gender,
                KycStatus = (byte)KycStatus.NotSubmitted,
                BgCheckStatus = (byte)BgCheckStatus.NotSubmitted,
                IsOnline = null,
                IsActive = true,
                CreatedAt = DateTime.UtcNow
            };

            await _unitOfWork.UserProfiles.AddAsync(profile);
            await _unitOfWork.SaveAsync();


            var companionCategories = dto.CategoryIds
                .Select(categoryId => new CompanionCategories
                {
                    UserProfileId = profile.Id,
                    CategoryId = categoryId,
                    IsActive = true,
                    CreatedAt = DateTime.UtcNow
                })
                .ToList();

            foreach (var companionCategory in companionCategories)
            {
                await _unitOfWork.CompanionCategories.AddAsync(companionCategory);
            }

            await _unitOfWork.SaveAsync();

            var result = _mapper.Map<UserProfileDto>(profile);
            result.FirstName = account.FirstName ?? string.Empty;
            result.LastName = account.LastName ?? string.Empty;
            result.PhoneNumber = account.PhoneNumber ?? string.Empty;
            result.Categories = _mapper.Map<List<CategoryDto>>(categories);

            return result;
        }



        public async Task ToggleOnlineStatusAsync(int accountId)
        {
            var account = await _unitOfWork.Accounts
                  .GetByIdAsync(accountId);

            if (account?.AccountType != "Companion")
                throw new UnauthorizedException(
                    "Only companions can toggle online status.");

            var profile = await _unitOfWork.UserProfiles
                .FindSingleAsync(p => p.AccountId == accountId);

            if (profile == null)
                throw new NotFoundException("Profile not found.");

            if (profile.KycStatus != (byte)KycStatus.Approved ||
                profile.BgCheckStatus != (byte)BgCheckStatus.Cleared)
                throw new UnauthorizedException(
                    "KYC and background check must be approved before going online.");

            var uploadedFiles = await _unitOfWork.UserFiles
                .FindAsync(f => f.UserProfileId == profile.Id);

            var uploadedTypes = uploadedFiles
                .Select(f => (UserFileType)f.FileType)
                .ToHashSet();

            var missingTypes = RequiredKycFileTypes
                .Where(t => !uploadedTypes.Contains(t))
                .ToList();

            if (missingTypes.Any())
                throw new BadRequestException(
                    $"Missing required KYC documents: {string.Join(", ", missingTypes)}");

            var categories = await _unitOfWork.CompanionCategories
                .FindAsync(c => c.UserProfileId == profile.Id);

            if (!categories.Any())
                throw new BadRequestException(
                    "Please select at least one category before going online.");

            profile.IsOnline = !profile.IsOnline;
            profile.UpdatedAt = DateTime.UtcNow;

            _unitOfWork.UserProfiles.Update(profile);
            await _unitOfWork.SaveAsync();
        }

        public async Task<UserProfileDto> GetProfileAsync(int accountId)
        {
            var profile = await _unitOfWork.UserProfiles
                .FindSingleAsync(p => p.AccountId == accountId);

            if (profile == null)
                throw new NotFoundException("Profile not found.");

            var account = await _unitOfWork.Accounts
                .GetByIdAsync(profile.AccountId);

            var dto = _mapper.Map<UserProfileDto>(profile);
            dto.FirstName = account?.FirstName ?? string.Empty;
            dto.LastName = account?.LastName ?? string.Empty;
            dto.PhoneNumber = account?.PhoneNumber ?? string.Empty;

            // Categories only for companions
            if (account?.AccountType == "Companion")
            {
                var companionCategories = await _unitOfWork.CompanionCategories
                    .FindAsync(c => c.UserProfileId == profile.Id);

                var categoryIds = companionCategories
                    .Select(c => c.CategoryId)
                    .ToList();

                if (categoryIds.Any())
                {
                    var categories = await _unitOfWork.Categories
                        .FindAsync(c => categoryIds.Contains(c.Id));

                    dto.Categories = _mapper.Map<List<CategoryDto>>(categories);
                }
                else
                {
                    dto.Categories = new List<CategoryDto>();
                }
            }

            return dto;
        }

        public async Task UpdateProfileAsync(
        int accountId, UpdateUserProfileDto dto)
        {
            var profile = await _unitOfWork.UserProfiles
                .FindSingleAsync(p => p.AccountId == accountId);

            if (profile == null)
                throw new NotFoundException("Profile not found.");

            if (dto.Gender.HasValue)
                profile.Gender = dto.Gender.Value;

            profile.UpdatedAt = DateTime.UtcNow;

            _unitOfWork.UserProfiles.Update(profile);
            await _unitOfWork.SaveAsync();
        }

        public async Task UpdateCategoriesAsync(int accountId, List<int> categoryIds)
        {
            var account = await _unitOfWork.Accounts
                .GetByIdAsync(accountId);

            if (account?.AccountType != "Companion")
                throw new UnauthorizedException(
                    "Only companions can update categories.");

            var profile = await _unitOfWork.UserProfiles
                .FindSingleAsync(p => p.AccountId == accountId);

            if (profile == null)
                throw new NotFoundException("Profile not found.");

            // Validate that all categories exist and are not deleted
            var categories = await _unitOfWork.Categories
                .FindAsync(c => categoryIds.Contains(c.Id) && c.IsActive);

            var foundIds = categories
                .Select(c => c.Id)
                .ToHashSet();

            var invalidIds = categoryIds
                .Where(id => !foundIds.Contains(id))
                .ToList();

            if (invalidIds.Any())
            {
                throw new NotFoundException(
                    $"Invalid or inactive category IDs: {string.Join(", ", invalidIds)}");
            }

            // Remove existing categories
            var existingCategories = await _unitOfWork.CompanionCategories
                .FindAsync(c => c.UserProfileId == profile.Id);

            foreach (var category in existingCategories)
            {
                _unitOfWork.CompanionCategories.Delete(category);
            }

            // Add new categories
            foreach (var categoryId in categoryIds)
            {
                await _unitOfWork.CompanionCategories.AddAsync(
                    new CompanionCategories
                    {
                        UserProfileId = profile.Id,
                        CategoryId = categoryId,
                        IsActive = true,
                        CreatedAt = DateTime.UtcNow
                    });
            }

            await _unitOfWork.SaveAsync();
        }

        public async Task UpdateLocationAsync(
       int accountId, UpdateLocationDto dto)
        {
            var account = await _unitOfWork.Accounts
                 .GetByIdAsync(accountId);

            if (account?.AccountType != "Companion")
                throw new UnauthorizedException(
                    "Only companions can update location.");

            var profile = await _unitOfWork.UserProfiles
                .FindSingleAsync(p => p.AccountId == accountId);

            if (profile == null)
                throw new NotFoundException("Profile not found.");

            profile.Latitude = dto.Latitude;
            profile.Longitude = dto.Longitude;
            profile.UpdatedAt = DateTime.UtcNow;

            _unitOfWork.UserProfiles.Update(profile);
            await _unitOfWork.SaveAsync();
        }


    }
}
