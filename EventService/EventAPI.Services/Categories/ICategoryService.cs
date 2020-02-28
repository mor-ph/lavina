using EventAPI.Models.Models;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace EventAPI.Services.Categories
{
    public interface ICategoryService
    {
        Task<Category> GetCategory(int id);
        Task<IEnumerable<Category>> GetCategories();
        Task<IEnumerable<Category>> GetSubCategories(int parentId);
        Task AddCategory(Category category);
        Task<bool> CategoryExists(string name);
    }
}
