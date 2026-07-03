using OurCompanion.Application.DTOs.Category;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OurCompanion.Application.DTOs.UserProfile
{
    public class UserProfileDto
    {
        public int Id { get; set; }
        public string FirstName { get; set; } = string.Empty;
        public string LastName { get; set; } = string.Empty;
        public string PhoneNumber { get; set; } = string.Empty;
        public byte? Gender { get; set; }
        public byte KycStatus { get; set; }
        public byte? BgCheckStatus { get; set; }
        public bool? IsOnline { get; set; }
        public decimal? AvgRating { get; set; }
        public List<CategoryDto> Categories { get; set; } = new();
    }
}
