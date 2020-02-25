using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using EventAPI.Data.Context;
using EventAPI.Models;
using EventAPI.Models.Models;
using EventAPI.Services.Categories;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace EventAPI.Controllers
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
        [HttpGet]
        public async Task<IActionResult> GetAllCategories()
        {
            var allCategories = await _categoryService.GetCategories();
            return Ok(allCategories);
        }

        [HttpGet("{id}")]
        public async Task<IActionResult> GetCategoryById(int id)
        {
            var category = await _categoryService.GetCategory(id);

            return Ok(category);
        }
        [HttpGet("getsub/{id}")]
        public async Task<IActionResult> GetSubCategories(int id)
        {
            var subCategories = await _categoryService.GetSubCategories(id);

            return Ok(subCategories);
        }
        [HttpPost]
        public async Task<IActionResult> AddCategory(Category category)
        {
            if(!ModelState.IsValid || category==null)
            {
                return BadRequest();
            }

            await _categoryService.AddCategory(category);
            return StatusCode(201);
        }

       
    }
}