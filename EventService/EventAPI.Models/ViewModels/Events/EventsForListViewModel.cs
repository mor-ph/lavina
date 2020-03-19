using EventAPI.Models.ViewModels.Categories;
using EventAPI.Models.ViewModels.Cities;
using System;

namespace EventAPI.Models.ViewModels.Events
{
    public class EventsForListViewModel
    {
        public int Id { get; set; }
        public DateTime EventStartDate { get; set; }
        public int? Recurring { get; set; }
        public DateTime UpdatedOn { get; set; }
        public string AddedAgo { get; set; }
        public string EventStatus { get; set; }
        public string Description { get; set; }
        public int PeopleNeeded { get; set; }
        public string Title { get; set; }
        public int UserCreatedById { get; set; }
        public string Address { get; set; }
        public bool IsActive { get; set; }

        public virtual SubCategoriesViewModel Category { get; set; }
        public virtual CityViewModel City { get; set; }
        public virtual UserViewModel User { get; set; }
        //public virtual ICollection<Userevent> Userevent { get; set; }
    }
}
