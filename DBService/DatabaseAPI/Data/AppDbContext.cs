using DatabaseAPI.Models;
using DatabaseAPI.Models.DbModels;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace DatabaseAPI.Data
{
    public class AppDbContext : IdentityDbContext<User,Role,int>
    {
        public DbSet<Event> Events { get; set; }
        public DbSet<Category> Categories { get; set; }
        public DbSet<Comment> Comments { get; set; }
        public DbSet<City> Cities { get; set; }



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

                // Indexes for "normalized" username and email, to allow efficient lookups
                b.HasIndex(u => u.NormalizedUserName).HasName("UserNameIndex").IsUnique();
                b.HasIndex(u => u.NormalizedEmail).HasName("EmailIndex").IsUnique();

                // Maps to the AspNetUsers table
                b.ToTable("Users");

                // A concurrency token for use with the optimistic concurrency checking
                b.Property(u => u.ConcurrencyStamp).IsConcurrencyToken();

                // Limit the size of columns to use efficient database types
                b.Property(u => u.UserName).IsRequired(true).HasMaxLength(256);
                b.Property(u => u.NormalizedUserName).HasMaxLength(256);
                b.Property(u => u.Email).IsRequired(true).HasMaxLength(256);
                b.Property(u => u.NormalizedEmail).HasMaxLength(256);

                // The relationships between User and other entity types
              

                // Each User can have many entries in the UserRole join table
                b.HasMany<Role>().WithOne().HasForeignKey(ur => ur.Id).IsRequired();
            });


            modelBuilder.Ignore<IdentityUserClaim<int>>();
            modelBuilder.Ignore<IdentityUserLogin<int>>();
            modelBuilder.Ignore<IdentityUserToken<int>>();
            modelBuilder.Ignore<IdentityRoleClaim<int>>();


            modelBuilder.Entity<Role>(b =>
            {
                // Primary key
                b.HasKey(r => r.Id);

                // Index for "normalized" role name to allow efficient lookups
                b.HasIndex(r => r.NormalizedName).HasName("RoleNameIndex").IsUnique();

                // Maps to the AspNetRoles table
                b.ToTable("Roles");

                // A concurrency token for use with the optimistic concurrency checking
                b.Property(r => r.ConcurrencyStamp).IsConcurrencyToken();

                // Limit the size of columns to use efficient database types
                b.Property(u => u.Name).HasMaxLength(256);
                b.Property(u => u.NormalizedName).HasMaxLength(256);

                // The relationships between Role and other entity types
                // Note that these relationships are configured with no navigation properties

                // Each Role can have many entries in the UserRole join table
                b.HasMany<IdentityUserRole<int>>().WithOne().HasForeignKey(ur => ur.RoleId).IsRequired();

            });

            modelBuilder.Entity<IdentityUserRole<int>>(b =>
            {
                // Primary key
                b.HasKey(r => new { r.UserId, r.RoleId });

                // Maps to the AspNetUserRoles table
                b.ToTable("UserRoles");
            });

            modelBuilder.Entity<Event>()
                .HasOne(e => e.Category)
                .WithMany(c => c.Events);

            modelBuilder.Entity<Category>()
                .HasOne(x => x.ParentCategory)
                .WithMany(x => x.SubCategories)
                .HasForeignKey(x => x.ParentCategoryID);

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
