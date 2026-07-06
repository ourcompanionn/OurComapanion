using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using OurCompanion.Infrastructure;
using OurCompanion.Domain.Entities;
namespace OurCompanion.Infrastructure.Persistence;

public partial class ApplicationDbContext : DbContext
{
    public ApplicationDbContext()
    {
    }

    public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options)
        : base(options)
    {
    }

    public virtual DbSet<Account> Accounts { get; set; }

    public virtual DbSet<UserSession> UserSessions { get; set; }

    public virtual DbSet<Categories> Categories { get; set; }

    public virtual DbSet<CompanionCategories> CompanionCategories { get; set; }

    public virtual DbSet<UserFiles> UserFiles { get; set; }

    public virtual DbSet<UserProfiles> UserProfiles { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        => optionsBuilder.UseSqlServer("Name=ConnectionStrings:DefaultConnection");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Categories>(entity =>
        {
            entity.Property(e => e.CreatedAt).HasDefaultValueSql("(getutcdate())");
            entity.Property(e => e.IsActive).HasDefaultValue(true);
            entity.Property(e => e.Name).HasMaxLength(100);
        });

        modelBuilder.Entity<CompanionCategories>(entity =>
        {
            entity.HasIndex(e => new { e.UserProfileId, e.CategoryId }, "UQ_CompanionCategories").IsUnique();

            entity.Property(e => e.CreatedAt).HasDefaultValueSql("(getutcdate())");
            entity.Property(e => e.IsActive).HasDefaultValue(true);

            entity.HasOne(d => d.Category).WithMany(p => p.CompanionCategories)
                .HasForeignKey(d => d.CategoryId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_CompanionCategories_Categories");

            entity.HasOne(d => d.UserProfile).WithMany(p => p.CompanionCategories)
                .HasForeignKey(d => d.UserProfileId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_CompanionCategories_UserProfiles");
        });

        modelBuilder.Entity<UserFiles>(entity =>
        {
            entity.HasIndex(e => new { e.UserProfileId, e.FileType }, "UQ_UserFiles").IsUnique();

            entity.Property(e => e.CreatedAt).HasDefaultValueSql("(getutcdate())");
            entity.Property(e => e.FileUrl).HasMaxLength(500);
            entity.Property(e => e.IsActive).HasDefaultValue(true);

            entity.HasOne(d => d.UserProfile).WithMany(p => p.UserFiles)
                .HasForeignKey(d => d.UserProfileId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_UserFiles_UserProfiles");
        });

        modelBuilder.Entity<UserProfiles>(entity =>
        {
            entity.HasOne(d => d.Account)
              .WithOne(p => p.UserProfile)
              .HasForeignKey<UserProfiles>(d => d.AccountId)
              .OnDelete(DeleteBehavior.ClientSetNull)
              .HasConstraintName("FK_UserProfiles_Accounts");
            entity.HasIndex(e => e.AccountId, "UQ_UserProfiles_AccountId").IsUnique();

            entity.Property(e => e.AvgRating).HasColumnType("decimal(3, 2)");
            entity.Property(e => e.CreatedAt).HasDefaultValueSql("(getutcdate())");
            entity.Property(e => e.IsActive).HasDefaultValue(true);
            entity.Property(e => e.KycStatus).HasDefaultValue((byte)1);
            entity.Property(e => e.Latitude).HasColumnType("decimal(9, 6)");
            entity.Property(e => e.Longitude).HasColumnType("decimal(9, 6)");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
