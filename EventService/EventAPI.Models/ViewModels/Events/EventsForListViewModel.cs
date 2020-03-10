using EventAPI.Models.Models;
using EventAPI.Models.ViewModels.Cities;
using System;
using System.Collections.Generic;
using System.Text;

namespace EventAPI.Models.ViewModels.Events
{
    public class EventsForListViewModel
    {

        public int Id { get; set; }
        public DateTime EventStartDate { get; set; }
        public DateTime CreatedOn { get; set; }
        public string Title { get; set; }
        public int UserCreatedById { get; set; }
        public string Address { get; set; }

        public virtual CityViewModel City { get; set; }
    }
}
