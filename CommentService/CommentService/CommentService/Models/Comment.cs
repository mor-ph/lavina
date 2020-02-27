using System;
using System.Collections.Generic;

namespace CommentService.Models
{
    public partial class Comment
    {
        public int Id { get; set; }
        public string Message { get; set; }
        public int? EventId { get; set; }
        public int? UserId { get; set; }
        public DateTime PostedOn { get; set; }
        public DateTime UpdatedOn { get; set; }
    }
}
