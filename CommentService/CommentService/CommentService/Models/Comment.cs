using CommentService.ViewModels;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace CommentService.Models
{
    public partial class Comment
    {
        public int Id { get; set; }
        public string Message { get; set; }
        public int? EventId { get; set; }
        public int? UserId { get; set; }
        public  DateTime PostedOn { get; set; }
        public  DateTime UpdatedOn { get; set; }

        public static implicit operator Comment(CommentViewModel vm)
        {
            return new Comment { Id = vm.Id, Message = vm.Message, EventId = vm.EventId,
                UserId = vm.UserId, PostedOn = vm.PostedOn, UpdatedOn = vm.UpdatedOn };
        }
    }
}
