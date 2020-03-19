using AutoMapper;
using EventAPI.Data.Context;
using EventAPI.Models.Models;
using EventAPI.Models.ViewModels.Categories;
using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EventAPI.Services.Categories
{
    public class CategoryService : ICategoryService
    {
        private readonly LetsPlayDbContext _context;
        private readonly IMapper _mapper;

        public CategoryService(LetsPlayDbContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }
        public async Task AddCategory(CategoriesAddViewModel category)
        {
            var addcategory = _mapper.Map<Category>(category);
            _context.Categories.Add(addcategory);
            await _context.SaveChangesAsync();

        }

        public async Task<IEnumerable<MainCategoriesViewModel>> GetCategories()
        {

            var mainCategories = await _context.Categories
                .ToListAsync();
            var categoriesToReturn = _mapper.Map<IEnumerable<MainCategoriesViewModel>>(mainCategories);
            return categoriesToReturn;
        }

        public async Task<Category> GetCategory(string name)
        {
            var category = await _context.Categories.Include(c => c.SubCategories).FirstOrDefaultAsync(c => c.Name == name);

            return category;
        }

        public async Task<IEnumerable<MainCategoriesViewModel>> GetMainCategories()
        {
            var categories = await _context.Categories.Where(c => c.ParentCategoryId == 1).ToListAsync();
            var categoriesToReturn = _mapper.Map<IEnumerable<MainCategoriesViewModel>>(categories);

            return categoriesToReturn;
        }
        public async Task<IEnumerable<SubCategoriesViewModel>> GetSubCategories(string parentName)
        {
            var category = await _context.Categories.FirstOrDefaultAsync(c => c.Name == parentName);

            var subCategories = await _context.Categories
                .Where(c => c.ParentCategoryId == category.Id)
                .ToListAsync();
            var subCategoriesToReturn = _mapper.Map<IEnumerable<SubCategoriesViewModel>>(subCategories);
            return subCategoriesToReturn;
        }
        public async Task<bool> CategoryExists(string name)
        {
            if (await _context.Categories.AnyAsync(u => u.Name == name))
                return true;

            return false;
        }

        public async Task<bool> ParentCategoryExists(int id)
        {
            var category = await _context.Categories.FirstOrDefaultAsync(c => c.Id == id);
            if (category.ParentCategoryId == 1)
            {
                return true;
            }
            else
            {
                return false;
            }
        }
    }
}
