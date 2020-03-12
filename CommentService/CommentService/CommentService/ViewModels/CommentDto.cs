using CommentService.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace CommentService.ViewModels
{
    public class CommentDto
    {
        public int Id { get; set; }
        public string Message { get; set; }
        public int? EventId { get; set; }
        public int? UserId { get; set; }
        public DateTime PostedOn { get; set; }
        public DateTime UpdatedOn { get; set; }
        public UserDto User { get; set; }
    }
}
