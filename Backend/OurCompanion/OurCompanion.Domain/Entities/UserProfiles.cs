using System;
using System.Collections.Generic;

namespace OurCompanion.Domain.Entities;

public partial class UserProfiles
{
    public int Id { get; set; }

    public int AccountId { get; set; }

    public byte? Gender { get; set; }

    public byte KycStatus { get; set; }

    public bool? IsOnline { get; set; }

    public decimal? Latitude { get; set; }

    public decimal? Longitude { get; set; }

    public decimal? AvgRating { get; set; }

    public byte? BgCheckStatus { get; set; }

    public bool IsActive { get; set; }

    public DateTime CreatedAt { get; set; }

    public DateTime? UpdatedAt { get; set; }

    public virtual ICollection<CompanionCategories> CompanionCategories { get; set; } = new List<CompanionCategories>();

    public virtual ICollection<UserFiles> UserFiles { get; set; } = new List<UserFiles>();

    public virtual Account Account { get; set; } = null!;
}
