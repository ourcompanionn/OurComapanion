namespace OurCompanion.Application.DTOs.Account;

public class AccountDto
{
    public int Id { get; set; }
    public string FirstName { get; set; } = string.Empty;
    public string LastName { get; set; } = string.Empty;
    public string Email { get; set; } = string.Empty;
    public string PhoneNumber { get; set; } = string.Empty;
    public string AccountType { get; set; } = string.Empty;
    public bool IsVerified { get; set; }
    public bool IsProfileCompleted { get; set; }
}
