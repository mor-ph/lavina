using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace DatabaseAPI.Models.DbModels
{
    public class UserEvent
    {
        public int UserID { get; set; }
        public User User { get; set; }
        public int EventID { get; set; }
        public Event Event { get; set; }


    }
}
