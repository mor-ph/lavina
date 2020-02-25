using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace CommentService.Models
{
    public class Comment
    {
        public int Id { get; set; }

        public int EventId { get; set; }

        public int UserId { get; set; }

        public string Message { get; set; }

        public DateTime CreatedAt { get; set; }

        public DateTime UpdatedAt { get; set; }
    }
}
