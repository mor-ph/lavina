using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace EventAPI.Models.ViewModels.Categories
{
    public class CategoriesAddViewModel
    {
        [Required]
        [MinLength(3,ErrorMessage = "Name cannot be less than {0}")]
        [MaxLength(30,ErrorMessage = "Name cannot be more than {0}")]
        public string Name { get; set; }
        public int? ParentCategoryId { get; set; }
    }
}
