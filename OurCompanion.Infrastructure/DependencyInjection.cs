using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using OurCompanion.Application.Interfaces.Repositories;
using OurCompanion.Application.Interfaces.Services;
using OurCompanion.Application.Services;
using OurCompanion.Infrastructure.Identity;
using OurCompanion.Infrastructure.Persistence;
using OurCompanion.Infrastructure.Persistence.Repositories;
using OurCompanion.Infrastructure.Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OurCompanion.Infrastructure
{
    public static class DependencyInjection
    {
        // The "this" keyword turns it into an Extension Method
        public static IServiceCollection AddInfrastructureServices(this IServiceCollection services)
        {
            // Register the Auth Services
            services.AddScoped<IAuthService, AuthService>();
            services.AddScoped<ITokenService, JwtService>();
            
            // Register the Mock Notification Service (Logs OTPs to console for now)
            services.AddScoped<INotificationService, MockNotificationService>();

            // Register UnitOfWork
            services.AddScoped<IUnitOfWork, UnitOfWork>();

            // Register DbContext
            services.AddDbContext<ApplicationDbContext>((sp, options) =>
            {
                var configuration = sp.GetRequiredService<IConfiguration>();
                options.UseSqlServer(configuration.GetConnectionString("DefaultConnection"));
            });

            return services;
        }
    }
}
