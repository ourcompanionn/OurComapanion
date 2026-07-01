using System;
using System.Text;
using Microsoft.IdentityModel.Tokens;
using Microsoft.IdentityModel.JsonWebTokens;
using System.Security.Claims;
using System.Security.Cryptography;
using OurCompanion.Domain.Entities;
using OurCompanion.Application.Interfaces.Services;
using Microsoft.Extensions.Configuration;


namespace OurCompanion.Infrastructure.Identity
{
    public class JwtService : ITokenService
    {
        private readonly IConfiguration _configuration;

        public JwtService(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        public string GenerateAccessToken(Account account)
        {
            var jwtSettings = _configuration.GetSection("JwtSettings");
            var secretkey = jwtSettings["Secret"] ?? throw new Exception("JWT Secret not configured.");

            var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(secretkey));

            var creds = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);

            //defining what data goes inside the token
            var claims = new Dictionary<string, object>
            {
                { JwtRegisteredClaimNames.Sub, account.Id.ToString() },
                { ClaimTypes.Role, account.AccountType },
                { JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString() }
            };

            // Modern .NET 8 Token Descriptor
            var descriptor = new SecurityTokenDescriptor
            {
                Issuer = jwtSettings["Issuer"],
                Audience = jwtSettings["Audience"],
                Claims = claims,
                Expires = DateTime.UtcNow.AddMinutes(Convert.ToDouble(jwtSettings["ExpiryMinutes"])),
                SigningCredentials = creds
            };

            var handler = new JsonWebTokenHandler();

            return handler.CreateToken(descriptor);
        }

        public string GenerateRefreshToken()
        {
            return Convert.ToBase64String(RandomNumberGenerator.GetBytes(32));
        }

    }
}
