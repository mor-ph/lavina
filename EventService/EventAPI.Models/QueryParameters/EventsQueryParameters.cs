using System;
using System.Collections.Generic;
using System.Text;

namespace EventAPI.Models.QueryParameters
{
    public class EventsQueryParameters
    {
        public string Category { get; set; }
        public string SubCategory { get; set; }
        public string Location { get; set; }
        public DateTime? Date { get; set; }
    }
}
