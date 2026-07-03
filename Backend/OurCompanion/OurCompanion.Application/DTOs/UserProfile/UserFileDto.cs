using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OurCompanion.Application.DTOs.UserProfile
{
    public class UserFileDto
    {
        public int Id { get; set; }
        public byte FileType { get; set; }
        public string FileUrl { get; set; } = string.Empty;
        public DateTime CreatedAt { get; set; }
    }
}
