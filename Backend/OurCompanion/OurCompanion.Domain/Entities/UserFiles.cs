using System;
using System.Collections.Generic;

namespace OurCompanion.Domain.Entities;

public partial class UserFiles
{
    public int Id { get; set; }

    public int UserProfileId { get; set; }

    public byte FileType { get; set; }

    public string FileUrl { get; set; } = null!;

    public bool IsActive { get; set; }

    public DateTime CreatedAt { get; set; }

    public DateTime? UpdatedAt { get; set; }

    public virtual UserProfiles UserProfile { get; set; } = null!;
}
