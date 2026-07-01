using FluentValidation;
using OurCompanion.Application.DTOs.Auth;

namespace OurCompanion.Application.Validators;

public class RequestOtpDtoValidator : AbstractValidator<RequestOtpDto>
{
    public RequestOtpDtoValidator()
    {
        RuleFor(x => x.PhoneNumber)
            .NotEmpty().WithMessage("Phone number is required.")
            .Matches(@"^\+?[1-9]\d{1,14}$").WithMessage("Invalid phone number format.");
    }
}
