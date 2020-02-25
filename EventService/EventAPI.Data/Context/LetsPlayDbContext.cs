using EventAPI.Models.Models;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Text;

namespace EventAPI.Data.Context
{
    public class LetsPlayDbContext : DbContext
    {
        public LetsPlayDbContext(DbContextOptions<LetsPlayDbContext> options) : base(options)
        {
        }
        public DbSet<Event> Events { get; set; }
        public DbSet<Category> Categories { get; set; }
    }

}
