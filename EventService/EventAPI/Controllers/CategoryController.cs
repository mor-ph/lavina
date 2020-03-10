using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AutoMapper;
using EventAPI.Data.Context;
using EventAPI.Models;
using EventAPI.Models.Models;
using EventAPI.Models.ViewModels.Categories;
using EventAPI.Services.Categories;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Cors;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace EventAPI.Controllers
{
    [EnableCors("AllowAnyOrigin")]
    [Route("api/[controller]")]
    [ApiController]
    // [Authorize]
    public class CategoryController : ControllerBase
    {
        private readonly ICategoryService _categoryService;
        private readonly IMapper _mapper;

        public CategoryController(ICategoryService categoryService, IMapper mapper)
        {
            _categoryService = categoryService;
            _mapper = mapper;
        }
        //GET: api/category
        [HttpGet]
        public async Task<IActionResult> GetAllCategories()
        {
            var allCategories = await _categoryService.GetCategories();

            var categoriesToReturn = _mapper.Map<IEnumerable<MainCategoriesViewModel>>(allCategories);
            return Ok(categoriesToReturn);
        }

        //GET: api/category/id
        [HttpGet("{id}")]
        public async Task<IActionResult> GetCategoryById(int id)
        {
            var category = await _categoryService.GetCategory(id);

            return Ok(category);
        }

        // GET: api/category/getsub/id
        [HttpGet("getsub/{name}")]
        public async Task<IActionResult> GetSubCategories(string name)
        {
            var subCategories = await _categoryService.GetSubCategories(name);

            var subCategoriesToReturn = _mapper.Map<IEnumerable<SubCategoriesViewModel>>(subCategories);
            return Ok(subCategoriesToReturn);
        }

        // POST: api/category
        [HttpPost]
        public async Task<IActionResult> AddCategory([FromBody] CategoriesAddViewModel category)
        {
            if(ModelState.IsValid)
            {
                if (await _categoryService.CategoryExists(category.Name))
                    return BadRequest("Category already exists");
                
                if(!(await _categoryService.ParentCategoryExists((int)category.ParentCategoryId)))
                {
                    return BadRequest("Parent Category is not a main Category");
                }

                var addcategory = _mapper.Map<Category>(category);

                await _categoryService.AddCategory(addcategory);
                return StatusCode(201, "Successfully added category");
 
            }
            return BadRequest();
        }

       
    }
}