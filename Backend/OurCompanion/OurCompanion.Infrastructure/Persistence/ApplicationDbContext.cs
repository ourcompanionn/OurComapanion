using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using OurCompanion.Domain.Entities;
using OurCompanion.Application.Interfaces;

namespace OurCompanion.Infrastructure.Persistence;

public partial class ApplicationDbContext : DbContext,IApplicationDbContext
{
    public ApplicationDbContext()
    {
    }

    public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options)
        : base(options)
    {
    }

    public virtual DbSet<Account> Accounts { get; set; }

    public virtual DbSet<OtpVerification> OtpVerifications { get; set; }

    public virtual DbSet<UserSession> UserSessions { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        => optionsBuilder.UseSqlServer("Name=DefaultConnection");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Account>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Accounts__3214EC07A72D3CC9");

            entity.Property(e => e.AccountType).HasMaxLength(20);
            entity.Property(e => e.CreatedAt).HasDefaultValueSql("(sysutcdatetime())");
            entity.Property(e => e.Email).HasMaxLength(200);
            entity.Property(e => e.FirstName).HasMaxLength(100);
            entity.Property(e => e.LastName).HasMaxLength(100);
            entity.Property(e => e.PhoneNumber).HasMaxLength(20);
            entity.Property(e => e.UpdatedAt).HasColumnType("datetime");
        });

        modelBuilder.Entity<OtpVerification>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__OtpVerif__3214EC077EF32538");

            entity.Property(e => e.LastUpdatedAt).HasDefaultValueSql("(sysutcdatetime())");
            entity.Property(e => e.OtpHash).HasMaxLength(255);
            entity.Property(e => e.Purpose).HasMaxLength(20);

            entity.Property(e => e.Identifier).HasMaxLength(255).IsRequired();
        });

        modelBuilder.Entity<UserSession>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__UserSess__3214EC07DB613E45");

            entity.Property(e => e.CreatedAt).HasDefaultValueSql("(sysutcdatetime())");
            entity.Property(e => e.DeviceIdentifier).HasMaxLength(255);
            entity.Property(e => e.DeviceName).HasMaxLength(255);
            entity.Property(e => e.Platform).HasMaxLength(50);
            entity.Property(e => e.FCMToken).HasMaxLength(500);

            entity.HasOne(d => d.Account).WithMany(p => p.UserSessions)
                .HasForeignKey(d => d.AccountId)
                .HasConstraintName("FK_UserSessions_Accounts");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
