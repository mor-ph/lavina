using EventAPI.Models.Enums;
using EventAPI.Models.Validations;
using System;
using System.ComponentModel.DataAnnotations;

namespace EventAPI.Models.ViewModels
{
    public class EventInputModel
    {
        public int Id { get; set; }
        [Required]
        [DateValidation(ErrorMessage = "Date must be in the future")]
        [DataType(DataType.DateTime, ErrorMessage = "Invalid Date")]
        public DateTime EventStartDate { get; set; }

        [DataType(DataType.DateTime, ErrorMessage = "Invalid Date")]
        public DateTime CreatedOn { get; set; } = DateTime.Now;

        [DataType(DataType.DateTime, ErrorMessage = "Invalid Date")]
        public DateTime UpdatedOn { get; set; } = DateTime.Now;

        [DataType(DataType.Text)]
        [MaxLength(600, ErrorMessage = "Description cannot be greater than 600")]
        public string Description { get; set; }

        [Required]
        [DataType(DataType.Text)]
        public string City { get; set; }

        [Required]
        [DataType(DataType.Text)]
        public string Category { get; set; }

        [DataType(DataType.Text)]
        public string SubCategory { get; set; }

        [Range(0, int.MaxValue, ErrorMessage = "Please enter valid integer Number")]
        public int PeopleNeeded { get; set; }

        [Required]
        [MaxLength(50, ErrorMessage = "Title cannot be greater than 50")]
        public string Title { get; set; }

        [Required]
        [Range(1, 3, ErrorMessage = "Invalid Status, availible status is 1-3")]
        public Status EventStatus { get; set; }
        [DataType(DataType.Text)]
        [MaxLength(100, ErrorMessage = "Address cannot be longer that 100 symbols")]
        public string Address { get; set; }

        [Range(1, 3, ErrorMessage = "Invalid Reccuring data")]
        public Recurring? Recurring { get; set; }
    }
}
