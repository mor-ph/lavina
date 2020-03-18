using AutoMapper;
using EventAPI.Models.Models;
using EventAPI.Models.ViewModels.Categories;
using EventAPI.Services.Categories;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace EventAPI.Controllers
{
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
        //GET: api/category/main
        [HttpGet("main")]
        public async Task<IActionResult> GetMainCategories()
        {
            var mainCategories = await _categoryService.GetMainCategories();

            var categoriesToReturn = _mapper.Map<IEnumerable<MainCategoriesViewModel>>(mainCategories);
            return Ok(categoriesToReturn);
        }

        // GET: api/category/getsub/name
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
            if (ModelState.IsValid)
            {
                if (await _categoryService.CategoryExists(category.Name))
                    return BadRequest("Category already exists");

                if (!(await _categoryService.ParentCategoryExists((int)category.ParentCategoryId)))
                {
                    return BadRequest("Parent Category is not a main Category");
                }

                var addcategory = _mapper.Map<Category>(category);

                await _categoryService.AddCategory(addcategory);
                return StatusCode(201, "Successfully added category");

            }
            return BadRequest();
        }
        // POST: api/category/name
        [HttpPost("{name}")]
        public async Task<IActionResult> AddSubCategory(string name,[FromBody] CategoriesAddViewModel category)
        {
            if (ModelState.IsValid)
            {
                var mainCategory = await _categoryService.GetCategory(name);
                if(mainCategory.ParentCategoryId!=1)
                {
                    return BadRequest("Not a main Category");
                }
                if (await _categoryService.CategoryExists(category.Name))
                    return BadRequest("Category already exists");
                category.ParentCategoryId = mainCategory.Id;
                var addcategory = _mapper.Map<Category>(category);

                await _categoryService.AddCategory(addcategory);
                return StatusCode(201, "Successfully added category");

            }
            return BadRequest();
        }
    }

}