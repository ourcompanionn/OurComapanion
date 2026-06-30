using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using OurCompanion.Domain.Entities;

namespace OurCompanion.Application.Interfaces.Services
{
    public interface ITokenService
    {
        string GenerateAccessToken(Account account);

        string GenerateRefreshToken();
    }
}
