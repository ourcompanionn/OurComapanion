using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using OurCompanion.Application.Common.Models;
using OurCompanion.Application.DTOs.Category;
using OurCompanion.Application.Interfaces.Services;

namespace OurCompanion.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CategoryController : ControllerBase
    {
        private readonly ICategoryService _categoryService;

        public CategoryController(ICategoryService categoryService)
        {
            _categoryService = categoryService;
        }

        // GET /api/categories
        [HttpGet]
        public async Task<IActionResult> GetCategories()
        {
            var result = await _categoryService.GetCategoriesAsync();

            return Ok(ApiResponse<object>.SuccessResponse(
                result,"Categories fetched successfully"));
        }

        [HttpPost]
        [Authorize(Roles ="Admin")]
        public async Task<IActionResult> CreateCategory(
       [FromBody] CreateCategoryDto dto)
        {
            var result = await _categoryService
                .CreateCategoryAsync(dto);

            return Ok(ApiResponse<object>.SuccessResponse(
                result,"Category created successfully"));
        }

        [HttpDelete("{id}")]
        [Authorize(Roles = "Admin")]
        public async Task<IActionResult> DeleteCategory(int id)
        {
            await _categoryService.DeleteCategoryAsync(id);

            return Ok(ApiResponse<object>.SuccessResponse(
                null, "Category deleted successfully"));
        }
    }
}
