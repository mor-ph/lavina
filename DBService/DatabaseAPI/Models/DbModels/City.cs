using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace DatabaseAPI.Models.DbModels
{
    public class City
    {
        [Key]
        public int ID { get; set; }
        [Required]
        public string Name { get; set; }
        public ICollection<Event> Events { get; set; }


    }
}
