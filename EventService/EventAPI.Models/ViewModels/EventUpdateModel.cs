using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using EventAPI.Models.Enums;

namespace EventAPI.Models.ViewModels
{
    public class EventUpdateModel
    {
        [NotMapped]
        [DataType(DataType.DateTime, ErrorMessage = "Invalid Date")]
        public DateTime UpdatedOn { get; set; } = DateTime.UtcNow;
        
        
        [Required]
        [Range(0, int.MaxValue, ErrorMessage = "Please enter valid integer Number")]
        public int PeopleNeeded { get; set; }

        [Required]
        [Range(1, 3, ErrorMessage = "Invalid Status, available status is 1-4")]
        public Status EventStatus { get; set; }
        

    }
}