using System;
using System.Collections.Generic;

namespace EventAPI.Models.Models
{
    public partial class Event
    {
        public Event()
        {
            Userevent = new HashSet<Userevent>();
        }

        public int Id { get; set; }
        public DateTime EventStartDate { get; set; }
        public DateTime CreatedOn { get; set; }
        public DateTime UpdatedOn { get; set; }
        public int EventStatus { get; set; }
        public string Description { get; set; }
        public int PeopleNeeded { get; set; }
        public string Title { get; set; }
        public int UserCreatedById { get; set; }
        public int CategoryId { get; set; }
        public int CityId { get; set; }
        public string Address { get; set; }

        public virtual Category Category { get; set; }
        public virtual City City { get; set; }
        public virtual ICollection<Userevent> Userevent { get; set; }
    }
}
