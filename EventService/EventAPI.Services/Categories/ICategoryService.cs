using EventAPI.Models.Models;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace EventAPI.Services.Categories
{
    public interface ICategoryService
    {
        Task<Category> GetCategory(string name);
        Task<IEnumerable<Category>> GetCategories();
        Task<IEnumerable<Category>> GetSubCategories(string parentName);
        Task AddCategory(Category category);
        Task<bool> CategoryExists(string name);

        Task<bool> ParentCategoryExists(int id);
        Task<IEnumerable<Category>> GetMainCategories();
    }
}
