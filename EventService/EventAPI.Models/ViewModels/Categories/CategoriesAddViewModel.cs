using System.ComponentModel.DataAnnotations;

namespace EventAPI.Models.ViewModels.Categories
{
    public class CategoriesAddViewModel
    {
        [Required]
        [MinLength(3, ErrorMessage = "Name cannot be less than {0}")]
        [MaxLength(30, ErrorMessage = "Name cannot be more than {0}")]
        public string Name { get; set; }
        public int? ParentCategoryId { get; set; }
    }
}
