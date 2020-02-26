using CommentService.Data;
using CommentService.Models;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace CommentService.Repository
{
    public class CommentsRepository : ICommentsRepository
    {

        CommentDbContext _context;
        public CommentsRepository(CommentDbContext context)
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
            return await _context.Comments.ToListAsync();
        }
    }
}
