using OurCompanion.Application.Interfaces.Services;
using Microsoft.Extensions.Logging;

namespace OurCompanion.Infrastructure.Services;

public class MockNotificationService : INotificationService
{
    private readonly ILogger<MockNotificationService> _logger;

    public MockNotificationService(ILogger<MockNotificationService> logger)
    {
        _logger = logger;
    }

    public Task SendOtpAsync(string? email, string phoneNumber, string otpCode)
    {
        // For development/MVP: Just log it to the console!
        _logger.LogInformation("================================================");
        _logger.LogInformation($"MOCK SMS SENT TO {phoneNumber}: Your OTP is {otpCode}");
        _logger.LogInformation("================================================");
        
        return Task.CompletedTask;
    }
}
