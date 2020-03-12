using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace CommentService.Models
{
    public class User
    {
        public User()
        {
            Comments = new HashSet<Comment>();
        }
        public int Id { get; set; }
        public string Username { get; set; }
        public string Password { get; set; }
        public string Email { get; set; }

        public virtual ICollection<Comment> Comments { get; set; }
    }
}
