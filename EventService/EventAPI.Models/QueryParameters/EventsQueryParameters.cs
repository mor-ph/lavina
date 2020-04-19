using System;

namespace EventAPI.Models.QueryParameters
{
    public class EventsQueryParameters
    {
        public string Category { get; set; }
        public string SubCategory { get; set; }
        public string Location { get; set; }

        public string sortOrder{ get; set;}
        public DateTime? Date { get; set; }
    }
}
