using System;
using System.Collections.Generic;
using System.Text;

namespace EventAPI.Models.Models
{
    public class User
    {
        public User()
        {
            Events = new HashSet<Event>();
        }
        public int Id { get; set; }
        public string Username { get; set; }
        public string Password { get; set; }
        public string Email { get; set; }

        public virtual ICollection<Event> Events { get; set; }
    }
}
