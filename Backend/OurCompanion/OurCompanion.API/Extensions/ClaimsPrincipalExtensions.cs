using System.Security.Claims;
using Microsoft.IdentityModel.JsonWebTokens;

namespace OurCompanion.API.Extensions
{
    public static class ClaimsPrincipalExtensions
    {
        public static int GetAccountId(this ClaimsPrincipal user)
        {
            var value = user.FindFirst(ClaimTypes.NameIdentifier)?.Value;

            if (string.IsNullOrEmpty(value))
                throw new UnauthorizedAccessException("Account ID not found in token.");

            return int.Parse(value);
        }

        public static string GetAccountType(this ClaimsPrincipal user)
        {
            var value = user.FindFirst(ClaimTypes.Role)?.Value;

            if (string.IsNullOrEmpty(value))
                throw new UnauthorizedAccessException("Account type not found in token.");

            return value;
        }

        public static bool IsCompanion(this ClaimsPrincipal user)
            => user.GetAccountType() == "Companion";

        public static bool IsCustomer(this ClaimsPrincipal user)
            => user.GetAccountType() == "Customer";
    }
}
