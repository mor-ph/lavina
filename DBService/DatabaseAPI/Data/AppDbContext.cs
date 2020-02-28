using DatabaseAPI.Models;
using DatabaseAPI.Models.DbModels;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace DatabaseAPI.Data
{
    public class AppDbContext : DbContext
    {
        public DbSet<Event> Events { get; set; }
        public DbSet<Category> Categories { get; set; }
        public DbSet<Comment> Comments { get; set; }
        public DbSet<City> Cities { get; set; }
        public DbSet<User> Users { get; set; }
        public DbSet<Role> Roles { get; set; }
        public DbSet<UserRole> UserRoles { get; set; }
        public DbSet<UserEvent> UserEvents { get; set; }



        public AppDbContext(DbContextOptions options) : base(options)
        {


        }
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {


            base.OnModelCreating(modelBuilder);

            modelBuilder.Entity<User>(b =>
            {
                // Primary key
                b.HasKey(u => u.Id);
            });

            modelBuilder.Entity<Role>(b =>
            {
                // Primary key
                b.HasKey(r => r.Id);
            });

            modelBuilder.Entity<UserRole>(b =>
            {
                // Primary key
                b.HasKey(r => new { r.UserId, r.RoleId });
                b.HasOne(ue => ue.User)
                .WithMany(ue => ue.UserRoles)
                .HasForeignKey(ue => ue.UserId);
                b.HasOne(ue => ue.Role)
                .WithMany(ue => ue.UserRoles)
                .HasForeignKey(ue => ue.RoleId);
                b.ToTable("UserRoles");
            });

            modelBuilder.Entity<Event>()
                .HasOne(e => e.Category)
                .WithMany(c => c.Events);

            modelBuilder.Entity<Category>()
                .HasOne(x => x.ParentCategory)
                .WithMany(x => x.SubCategories)
                .HasForeignKey(x => x.ParentCategoryID);
            modelBuilder.Entity<Category>()
                .HasIndex(c => c.Name).IsUnique();

            modelBuilder.Entity<Comment>()
                .HasOne(c => c.User)
                .WithMany(u => u.Comments);

            modelBuilder.Entity<Comment>()
                .HasOne(c => c.Event)
                .WithMany(e => e.Comments);


            modelBuilder.Entity<UserEvent>()
                .HasKey(uv => new { uv.UserID, uv.EventID });
            modelBuilder.Entity<UserEvent>()
                .HasOne(uv => uv.User)
                .WithMany(u => u.Events)
                .HasForeignKey(uv => uv.UserID);
            modelBuilder.Entity<UserEvent>()
                .HasOne(uv => uv.Event)
                .WithMany(e => e.Participants)
                .HasForeignKey(uv => uv.EventID);

            modelBuilder.Entity<City>()
                .HasMany(c => c.Events)
                .WithOne(e => e.City);



        }


    }
}
