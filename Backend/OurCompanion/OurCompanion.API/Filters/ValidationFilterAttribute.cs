using FluentValidation;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;

namespace OurCompanion.API.Filters
{
    public class ValidationFilterAttribute : IAsyncActionFilter
    {
        public async Task OnActionExecutionAsync(ActionExecutingContext context, ActionExecutionDelegate next)
        {
            // Get the incoming DTO from the controller request (e.g. RequestOtpDto)
            var argument = context.ActionArguments.Values.FirstOrDefault(v => v != null);

            if (argument != null)
            {
                // Ask the Dependency Injection container if there is a validator for this DTO
                var validatorType = typeof(IValidator<>).MakeGenericType(argument.GetType());
                var validator = context.HttpContext.RequestServices.GetService(validatorType) as IValidator;

                if (validator != null)
                {
                    // If a validator exists, run it!
                    var validationContext = new ValidationContext<object>(argument);
                    var validationResult = await validator.ValidateAsync(validationContext);

                    if (!validationResult.IsValid)
                    {
                        // Format the errors nicely to return to the frontend
                        var errors = validationResult.Errors
                            .GroupBy(e => e.PropertyName)
                            .ToDictionary(
                                g => g.Key,
                                g => g.Select(e => e.ErrorMessage).ToArray()
                            );

                        // Instantly return 400 Bad Request (your AuthService never gets hit)
                        context.Result = new BadRequestObjectResult(new { Errors = errors });
                        return;
                    }
                }
            }

            // Validation passed (or no validator exists), continue to the controller
            await next();
        }
    }
}
