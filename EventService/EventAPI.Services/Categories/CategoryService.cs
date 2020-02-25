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
            var allCategories = await _context.Categories.ToListAsync();

            return allCategories;
        }

        public async Task<Category> GetCategory(int id)
        {
            var category = await _context.Categories.FirstOrDefaultAsync(c => c.Id == id);

            return category;
        }

        public async Task<IEnumerable<Category>> GetSubCategories(int parentId)
        {
            var subCategories = await _context.Categories
                .Where(c => c.ParentCategoryId == parentId)
                .ToListAsync();

            return subCategories;
        }
    }
}
