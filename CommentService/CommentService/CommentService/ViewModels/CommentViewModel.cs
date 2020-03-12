using CommentService.Models;
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

        [Required]
        public int EventId { get; set; }

        [Required]
        public int UserId { get; set; }

        [Required]
        [StringLength(600, MinimumLength = 1)]
        [DataType(DataType.Text)]
        [RegularExpression(@"[\S+]+")]
        public string Message { get; set; }

        public DateTime PostedOn { get; set; }
        public DateTime UpdatedOn { get; set; }

    }
}
