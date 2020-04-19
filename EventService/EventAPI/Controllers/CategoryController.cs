using EventAPI.Models.ViewModels.Categories;
using EventAPI.Services.Categories;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Threading.Tasks;

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
        //GET: api/category
        [HttpGet]
        public async Task<IActionResult> GetAllCategories()
        {
            var allCategories = await _categoryService.GetCategories();

            return Ok(allCategories);
        }
        //GET: api/category/main
        [HttpGet("main")]
        public async Task<IActionResult> GetMainCategories()
        {
            var mainCategories = await _categoryService.GetMainCategories();

            return Ok(mainCategories);
        }

        // GET: api/category/getsub/name
        [HttpGet("getsub/{name}")]
        public async Task<IActionResult> GetSubCategories(string name)
        {
            var subCategories = await _categoryService.GetSubCategories(name);


            return Ok(subCategories);
        }

        [Authorize]
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


                await _categoryService.AddCategory(category);
                return StatusCode(201, "Successfully added category");

            }
            return BadRequest();
        }
        [Authorize]
        // POST: api/category/name
        [HttpPost("{name}")]
        public async Task<IActionResult> AddSubCategory(string name, [FromBody] CategoriesAddViewModel category)
        {
            if (ModelState.IsValid)
            {
                var mainCategory = await _categoryService.GetCategory(name);
                if (mainCategory.ParentCategoryId != 1)
                {
                    return BadRequest("Not a main Category");
                }
                if (await _categoryService.CategoryExists(category.Name))
                    return BadRequest("Category already exists");
                category.ParentCategoryId = mainCategory.Id;

                await _categoryService.AddCategory(category);
                return StatusCode(201, "Successfully added category");

            }
            return BadRequest();
        }
    }

}