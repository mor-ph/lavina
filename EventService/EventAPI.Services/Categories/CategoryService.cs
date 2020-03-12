using EventAPI.Data.Context;
using EventAPI.Models.Models;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EventAPI.Services.Categories
{
    public class CategoryService : ICategoryService
    {
        private readonly LetsPlayDbContext _context;

        public CategoryService(LetsPlayDbContext context)
        {
            _context = context;
        }
        public async Task AddCategory(Category category)
        {
            _context.Categories.Add(category);
            await _context.SaveChangesAsync();

        }

        public async Task<IEnumerable<Category>> GetCategories()
        {

            var mainCategories = await _context.Categories
                .ToListAsync();

            return mainCategories;
        }

        public async Task<Category> GetCategory(int id)
        {
            var category = await _context.Categories.Include(c => c.SubCategories).FirstOrDefaultAsync(c => c.Id == id);

            return category;
        }

        public async Task<IEnumerable<Category>> GetSubCategories(string parentName)
        {
            var category = await _context.Categories.FirstOrDefaultAsync(c => c.Name == parentName);

            var subCategories = await _context.Categories
                .Where(c => c.ParentCategoryId == category.Id)
                .ToListAsync();

            return subCategories;
        }
        public async Task<bool> CategoryExists(string name)
        {
            if (await _context.Categories.AnyAsync(u => u.Name == name))
                return true;

            return false;
        }

        public async  Task<bool> ParentCategoryExists(int id)
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
