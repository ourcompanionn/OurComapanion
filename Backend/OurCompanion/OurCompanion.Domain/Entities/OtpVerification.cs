using System;
using System.Collections.Generic;

namespace OurCompanion.Domain.Entities;

public partial class OtpVerification
{
    public int Id { get; set; }

    public string Identifier { get; set; } = string.Empty; //email or phone

    public string OtpHash { get; set; } = null!;

    public string Purpose { get; set; } = null!;

    public int AttemptCount { get; set; }

    public bool IsUsed { get; set; }

    public DateTime ExpiresAt { get; set; }

    public DateTime LastUpdatedAt { get; set; }

}
