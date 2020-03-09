using EventAPI.Models.Models;
using System;
using System.Collections.Generic;
using System.Text;

namespace EventAPI.Models.ViewModels.Categories
{
    public class MainCategoriesViewModel
    {
        public int Id { get; set; }
        public string Name { get; set; }
        //public virtual ICollection<EventInputModel> Events { get; set; }
        //public virtual ICollection<SubCategoriesViewModel> SubCategories { get; set; }
    }
}
