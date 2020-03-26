using EventAPI.Models.Models;
using EventAPI.Models.ViewModels.Categories;
using EventAPI.Models.ViewModels.Cities;
using System;
using System.Collections.Generic;
using System.Text;

namespace EventAPI.Models.ViewModels.Events
{
    public class EventDetailsViewModel
    {
        public int Id { get; set; }
        public DateTime EventStartDate { get; set; }
        public string Recurring { get; set; }
        public string AddedAgo{ get; set; }
        public string EventStatus { get; set; }
        public string Description { get; set; }
        public int PeopleNeeded { get; set; }
        public string Title { get; set; }
        public string Address { get; set; }
        public virtual UserViewModel User { get; set; }
        public virtual MainCategoriesViewModel MainCategory { get; set; }
        public virtual CityViewModel City { get; set; }
        public virtual MainCategoriesViewModel SubCategory { get; set; }
        public virtual ICollection<Userevent> Userevent { get; set; }
        public virtual ICollection<Comment> Comments { get; set; }
    }
}
