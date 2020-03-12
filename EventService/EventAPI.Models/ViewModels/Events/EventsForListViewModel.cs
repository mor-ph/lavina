using EventAPI.Models.Enums;
using EventAPI.Models.Models;
using EventAPI.Models.ViewModels.Categories;
using EventAPI.Models.ViewModels.Cities;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion.Internal;
using Newtonsoft.Json.Converters;
using System;
using System.Collections.Generic;
using System.Text;
using System.Text.Json.Serialization;

namespace EventAPI.Models.ViewModels.Events
{
    public class EventsForListViewModel
    {
        public int Id { get; set; }
        public DateTime EventStartDate { get; set; }
        public int? Recurring { get; set; }
        public DateTime CreatedOn { get; set; }
        public DateTime UpdatedOn { get; set; }
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
