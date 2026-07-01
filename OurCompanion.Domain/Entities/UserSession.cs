using System;
using System.Collections.Generic;

namespace OurCompanion.Domain.Entities;
public partial class UserSession
{
    public int Id { get; set; }

    public int AccountId { get; set; }

    public string DeviceIdentifier { get; set; } = null!;

    public string? DeviceName { get; set; }

    public string Platform { get; set; } = null!;

    public string RefreshToken { get; set; } = null!;

    public bool IsRevoked { get; set; }

    public DateTime ExpiresAt { get; set; }

    public DateTime LastUsedAt { get; set; }

    public DateTime CreatedAt { get; set; }
    public string? FCMToken { get; set; }

    public Account Account { get; set; } = null!;
}
