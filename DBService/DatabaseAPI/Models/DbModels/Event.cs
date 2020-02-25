using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace DatabaseAPI.Models.DbModels
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
        [Required]
        public DateTime EventStartDate { get; set; }
        public DateTime CreatedOn { get; set; } = DateTime.UtcNow;
        public DateTime UpdatedOn { get; set; } = DateTime.UtcNow;
        public Status EventStatus { get; set; }
        public string Description { get; set; }
        public int PeopleNeeded { get; set; }
        [Required]
        public string Title { get; set; }
        [Required]
        [ForeignKey("User")]
        public int UserCreatedByID { get; set; }
        public User User { get; set; }
        [Required]
        public Category Category { get; set; }
        [Required]
        public City City { get; set; }
        [Required]
        public string Address { get; set; }
        public ICollection<Comment> Comments { get; set; }
        public ICollection<UserEvent> Participants{ get; set; }








    }
}
