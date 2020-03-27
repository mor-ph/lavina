using CommentService.Models;
using CommentService.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace CommentService.Repository
{
    public interface ICommentsRepository
    {
        Task Add(Comment item);

        Task<IEnumerable<Comment>> GetAll();

        Task<IEnumerable<Comment>> GetCommentsForEvent(int id);
        Task<User> GetUser(int id);
    }
}
