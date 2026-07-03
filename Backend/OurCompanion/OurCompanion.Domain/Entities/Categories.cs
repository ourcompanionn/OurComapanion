using System;
using System.Collections.Generic;

namespace OurCompanion.Domain.Entities;

public partial class Categories
{
    public int Id { get; set; }

    public string Name { get; set; } = null!;

    public bool IsActive { get; set; }

    public DateTime CreatedAt { get; set; }

    public DateTime? UpdatedAt { get; set; }

    public virtual ICollection<CompanionCategories> CompanionCategories { get; set; } = new List<CompanionCategories>();
}
