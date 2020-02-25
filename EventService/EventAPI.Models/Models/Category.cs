using System;
using System.Collections.Generic;
using System.Text;

namespace EventAPI.Models.Models
{
    public class Category
    {
        public Category()
        {
            Events = new HashSet<Event>();
            Children = new HashSet<Category>();
        }
        public int Id { get; set; }
        public string Name { get; set; }
        public int? ParentId { get; set; }
        public DateTime CreatedAt { get; set; }
        public DateTime UpdatedAt { get; set; }

        public virtual Category Parent { get; set; }
        public virtual ICollection<Event> Events { get; set; }
        public virtual ICollection<Category> Children { get; set; }
    }
}
