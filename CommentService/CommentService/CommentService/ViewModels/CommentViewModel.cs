using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace CommentService.ViewModels
{
    public class CommentViewModel
    {
        [Key]
        public int Id { get; set; }

        public int EventId { get; set; }

        public int UserId { get; set; }

        [Required]
        [StringLength(100)]
        [DataType(DataType.Text)]
        public string Message { get; set; }

    }
}
