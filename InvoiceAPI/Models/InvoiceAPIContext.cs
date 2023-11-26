using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;

namespace InvoiceAPI.Models
{
    public partial class InvoiceAPIContext : DbContext
    {
        public InvoiceAPIContext()
        {
        }

        public InvoiceAPIContext(DbContextOptions<InvoiceAPIContext> options)
            : base(options)
        {
        }

        public virtual DbSet<Manufacturer> Manufacturers { get; set; } = null!;
        public virtual DbSet<Product> Products { get; set; } = null!;
        public virtual DbSet<PurchaseHistory> PurchaseHistories { get; set; } = null!;
        public virtual DbSet<Rate> Rates { get; set; } = null!;
        public virtual DbSet<Role> Roles { get; set; } = null!;
        public virtual DbSet<User> Users { get; set; } = null!;
        public virtual DbSet<UserRole> UserRoles { get; set; } = null!;

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
                optionsBuilder.UseSqlServer("Name = ConnectionStrings:DefaultConnection");
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Manufacturer>(entity =>
            {
                entity.HasIndex(e => e.Name, "IX_Manufacturers")
                    .IsUnique();

                entity.Property(e => e.Name).HasMaxLength(50);
            });

            modelBuilder.Entity<Product>(entity =>
            {
                entity.HasIndex(e => e.ManufacturerId, "IX_ManufacturerId");

                entity.HasIndex(e => e.Name, "IX_Products")
                    .IsUnique();

                entity.Property(e => e.Name).HasMaxLength(50);

                entity.HasOne(d => d.Manufacturer)
                    .WithMany(p => p.Products)
                    .HasForeignKey(d => d.ManufacturerId)
                    .HasConstraintName("FK_dbo.Products_dbo.Manufacturers_ManufacturerId");
            });

            modelBuilder.Entity<PurchaseHistory>(entity =>
            {
                entity.HasIndex(e => e.RateId, "IX_RateId");

                entity.Property(e => e.Date).HasColumnType("datetime");

                entity.HasOne(d => d.Rate)
                    .WithMany(p => p.PurchaseHistories)
                    .HasForeignKey(d => d.RateId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_dbo.PurchaseHistories_dbo.Rates_RateId");
            });

            modelBuilder.Entity<Rate>(entity =>
            {
                entity.HasIndex(e => e.ProductId, "IX_ProductId");

                entity.Property(e => e.Date).HasColumnType("datetime");

                entity.HasOne(d => d.Product)
                    .WithMany(p => p.Rates)
                    .HasForeignKey(d => d.ProductId)
                    .HasConstraintName("FK_dbo.Rates_dbo.Products_ProductId");
            });

            modelBuilder.Entity<Role>(entity =>
            {
                entity.Property(e => e.Id).HasMaxLength(128);

                entity.Property(e => e.Name).HasMaxLength(256);
            });

            modelBuilder.Entity<User>(entity =>
            {
                entity.Property(e => e.Id).HasMaxLength(128);

                entity.Property(e => e.Email).HasMaxLength(256);

                entity.Property(e => e.FirstName)
                    .HasMaxLength(128)
                    .IsUnicode(false);

                entity.Property(e => e.LastName)
                    .HasMaxLength(128)
                    .IsUnicode(false);

                entity.Property(e => e.LockoutEndDateUtc).HasColumnType("datetime");

                entity.Property(e => e.UserName).HasMaxLength(256);
            });

            modelBuilder.Entity<UserRole>(entity =>
            {
                entity.HasKey(e => new { e.UserId, e.RoleId })
                    .HasName("PK_dbo.UserRoles");

                entity.Property(e => e.UserId).HasMaxLength(128);

                entity.Property(e => e.RoleId).HasMaxLength(128);
            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
