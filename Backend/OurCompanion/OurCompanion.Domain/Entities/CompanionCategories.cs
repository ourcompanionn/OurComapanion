using System;
using System.Collections.Generic;

namespace OurCompanion.Domain.Entities;

public partial class CompanionCategories
{
    public int Id { get; set; }

    public int UserProfileId { get; set; }

    public int CategoryId { get; set; }

    public bool IsActive { get; set; }

    public DateTime CreatedAt { get; set; }

    public DateTime? UpdatedAt { get; set; }

    public virtual Categories Category { get; set; } = null!;

    public virtual UserProfiles UserProfile { get; set; } = null!;
}
