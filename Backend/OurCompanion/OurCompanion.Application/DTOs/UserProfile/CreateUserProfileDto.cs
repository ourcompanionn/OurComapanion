using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OurCompanion.Application.DTOs.UserProfile
{
    public class CreateUserProfileDto
    {
        public byte Gender { get; set; }
        public List<int> CategoryIds { get; set; } = new();
    }
}
