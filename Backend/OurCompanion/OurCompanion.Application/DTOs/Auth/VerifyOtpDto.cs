namespace OurCompanion.Application.DTOs.Auth;

public class VerifyOtpDto
{
    public string PhoneNumber { get; set; } = string.Empty;
    public string OtpCode { get; set; } = string.Empty;

    // Standard device tracking fields for session management
    public string DeviceIdentifier { get; set; } = string.Empty;
    public string Platform { get; set; } = string.Empty;
    public string? DeviceName { get; set; }
}
