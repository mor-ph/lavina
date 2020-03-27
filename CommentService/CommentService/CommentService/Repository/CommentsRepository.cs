using CommentService.Data;
using CommentService.Models;
using CommentService.ViewModels;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace CommentService.Repository
{
    public class CommentsRepository : ICommentsRepository
    {

        CommentDBContext _context;
        public CommentsRepository(CommentDBContext context)
        {
            _context = context;
        }

        public async Task Add(Comment item)
        {
            await _context.Comments.AddAsync(item);
            await _context.SaveChangesAsync();
        }
     
        public async Task<IEnumerable<Comment>> GetAll()
        {
            var comments = await _context.Comments
                .Include(c => c.User)
                .ToListAsync();
            return comments;
        }
        public async Task<IEnumerable<Comment>> GetCommentsForEvent(int id)
        {
            var commentsList = await _context.Comments.Include(u => u.User).Where(c => c.EventId == id).ToListAsync();

            return commentsList;
        }


    }
}
