using OurCompanion.Application.DTOs.Account;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OurCompanion.Application.DTOs.Auth
{
    public class AuthResult
    {
        public bool IsRegistrationRequired { get; set; }
        public string? AccessToken { get; set; } = string.Empty;
        public string? RefreshToken { get; set; } = string.Empty;
        public AccountDto? Account { get; set; } = null;
    }
}
