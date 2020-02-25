using System;
using System.Collections.Generic;

namespace EventAPI.Models.Models
{
    public partial class City
    {
        public City()
        {
            Events = new HashSet<Event>();
        }

        public int Id { get; set; }
        public string Name { get; set; }

        public virtual ICollection<Event> Events { get; set; }
    }
}
