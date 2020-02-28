using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace DatabaseAPI.Models.DbModels
{
    public class Comment
    {
        [Key]
        public int ID { get; set; }
        [Required]
        public string Message { get; set; }

        public Event Event { get; set; }
        public User User { get; set; }

        public DateTime PostedOn { get; set; } = DateTime.UtcNow;
        public DateTime UpdatedOn { get; set; } = DateTime.UtcNow;



    }
}
