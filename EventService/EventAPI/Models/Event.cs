using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace EventAPI.Models
{
    public enum Status
    {
        
       
        Created = 1,
        Repeating = 2,
        Finished = 3,


    }
    public class Event
    {

        [Key]
        public int ID { get; set; }
        public DateTime EventStartDate { get; set; }
        public DateTime CreatedOn { get; set; } = DateTime.UtcNow;
        public DateTime UpdatedOn { get; set; } = DateTime.UtcNow;
        public Status EventStatus { get; set; }
        public string Description { get; set; }
        public string Location { get; set; }
        public int PeopleNeeded { get; set; }
        public string Title { get; set; }
        public int CreatedBy { get; set; }

        


    }
}
