using EventAPI.Models.Models;
using EventAPI.Models.ViewModels.Categories;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace EventAPI.Services.Categories
{
    public interface ICategoryService
    {
        Task<Category> GetCategory(string name);
        Task<IEnumerable<MainCategoriesViewModel>> GetCategories();
        Task<IEnumerable<MainCategoriesViewModel>> GetSubCategories(string parentName);
        Task AddCategory(CategoriesAddViewModel category);
        Task<bool> CategoryExists(string name);

        Task<bool> ParentCategoryExists(int id);
        Task<IEnumerable<MainCategoriesViewModel>> GetMainCategories();
    }
}
