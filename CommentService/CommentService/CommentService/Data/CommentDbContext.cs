using CommentService.Models;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace CommentService.Data
{
    public class CommentDbContext : DbContext
    {
        public CommentDbContext(DbContextOptions<CommentDbContext> options)
            : base(options)
        {
        }

        public DbSet<Comment> Comments { get; set; }


    }
}
