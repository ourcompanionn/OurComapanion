using System;
using System.Collections.Generic;

namespace OurCompanion.Domain.Entities;

public partial class Account
{
    public int Id { get; set; }

    public string FirstName { get; set; } = null!;

    public string LastName { get; set; } = null!;

    public string Email { get; set; } = null!;

    public string PhoneNumber { get; set; } = null!;

    public string AccountType { get; set; } = null!;

    public bool IsVerified { get; set; }

    public bool IsProfileCompleted { get; set; }

    public bool IsActive { get; set; }

    public DateTime? LastLoginAt { get; set; }

    public DateTime CreatedAt { get; set; }

    public DateTime? UpdatedAt { get; set; }

    public ICollection<UserSession> UserSessions { get; set; } = new List<UserSession>();
}
