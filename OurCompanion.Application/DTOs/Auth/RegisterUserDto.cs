namespace OurCompanion.Application.DTOs.Auth;

public class RegisterUserDto
{
    public string FirstName { get; set; } = string.Empty;
    public string LastName { get; set; } = string.Empty;
    public string? Email { get; set; }

    // We pass the phone here so the backend knows WHO is registering
    public string PhoneNumber { get; set; } = string.Empty;
    public string AccountType { get; set; } = string.Empty;

    public string DeviceIdentifier { get; set; } = string.Empty;
    public string Platform { get; set; } = string.Empty;
    public string? DeviceName { get; set; }=string.Empty;
}
