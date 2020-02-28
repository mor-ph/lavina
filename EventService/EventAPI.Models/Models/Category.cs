using System;
using System.Collections.Generic;

namespace EventAPI.Models.Models
{
    public partial class Category
    {
        public Category()
        {
            Events = new HashSet<Event>();
            SubCategories = new HashSet<Category>();
        }

        public int Id { get; set; }
        public string Name { get; set; }
        public int? ParentCategoryId { get; set; }

        public virtual Category ParentCategory { get; set; }
        public virtual ICollection<Event> Events { get; set; }
        public virtual ICollection<Category> SubCategories { get; set; }
    }
}
