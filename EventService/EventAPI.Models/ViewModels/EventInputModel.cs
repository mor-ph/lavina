using EventAPI.Models.Enums;
using EventAPI.Models.Validations;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace EventAPI.Models.ViewModels
{
    public class EventInputModel
    {
        public int ID { get; set; }

        [Required]
        [DateValidation(ErrorMessage = "Date must be in the future")]
        [DataType(DataType.DateTime, ErrorMessage = "Invalid Date")]
        public DateTime EventStartDate { get; set; }

        [Required]
        [DataType(DataType.DateTime, ErrorMessage = "Invalid Date")]
        public DateTime CreatedOn { get; set; }

        [Required]
        [DataType(DataType.DateTime, ErrorMessage = "Invalid Date")]
        public DateTime UpdatedOn { get; set; }

        [Required]
        [DataType(DataType.Text)]
        [MaxLength(100, ErrorMessage = "Description cannot be greater than {0}")]
        public string Description { get; set; }
        public string Location { get; set; }

        [Required]
        [Range(0, int.MaxValue, ErrorMessage = "Please enter valid integer Number")]
        public int PeopleNeeded { get; set; }

        [Required]
        [MaxLength(50, ErrorMessage = "Title cannot be greater than {0}")]
        public string Title { get; set; }

        [Required]
        [Range(1, int.MaxValue, ErrorMessage = "Invalid Status")]
        public Status EventStatus { get; set; }

        public int CreatedBy { get; set; }
    }
}
