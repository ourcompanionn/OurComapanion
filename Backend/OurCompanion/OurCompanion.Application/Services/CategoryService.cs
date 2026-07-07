using AutoMapper;
using OurCompanion.Application.Common.Exceptions;
using OurCompanion.Application.DTOs.Category;
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
    public class CategoryService : ICategoryService
    {
        private readonly IUnitOfWork _unitOfWork;
        private readonly IMapper _mapper;
        public CategoryService(IUnitOfWork unitOfWork, IMapper mapper)
        {
            _unitOfWork = unitOfWork;
            _mapper = mapper;
        }

        public async Task<List<CategoryDto>> GetCategoriesAsync()
        {
            var categories = await _unitOfWork.Categories
                .FindAsync(c => c.IsActive == true);

            return _mapper.Map<List<CategoryDto>>(categories);
        }

        public async Task<CategoryDto> CreateCategoryAsync(CreateCategoryDto dto)
        {
            // check duplicate
            var existing = await _unitOfWork.Categories
                .FindSingleAsync(c => c.Name == dto.Name);

            if (existing != null)
                throw new AlreadyExistException(
                    $"Category '{dto.Name}' already exists.");

            var category = new Categories
            {
                Name = dto.Name,
                IsActive = true,
                CreatedAt = DateTime.UtcNow
            };

            await _unitOfWork.Categories.AddAsync(category);
            await _unitOfWork.SaveAsync();

            return _mapper.Map<CategoryDto>(category);
        }

        public async Task DeleteCategoryAsync(int id)
        {
            var category = await _unitOfWork.Categories
                .GetByIdAsync(id);

            if (category == null)
                throw new NotFoundException("Category not found.");

            // soft delete — set IsActive = false
            category.IsActive = false;
            category.UpdatedAt = DateTime.UtcNow;

            _unitOfWork.Categories.Update(category);
            await _unitOfWork.SaveAsync();
        }
    }
}
