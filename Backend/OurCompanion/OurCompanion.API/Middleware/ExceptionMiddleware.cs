using System.Net;
using System.Text.Json;
using Microsoft.AspNetCore.Http.HttpResults;
using OurCompanion.Application.Common.Exceptions;

namespace OurCompanion.API.Middleware
{
    public class ExceptionMiddleware
    {
        private readonly RequestDelegate _next;

        public ExceptionMiddleware(RequestDelegate next)
        {
            _next = next;
        }

        public async Task InvokeAsync(HttpContext context)
        {
            try
            {
                // Try to run the controller and service normally
                await _next(context);
            }
            catch (Exception ex)
            {
                // If ANY service throws an error, this catches it
                await HandleExceptionAsync(context, ex);
            }
        }

        private static Task HandleExceptionAsync(HttpContext context, Exception exception)
        {
            context.Response.ContentType = "application/json";
            // Determine the HTTP Status code based on the type of Exception
            var statusCode = exception switch
            {
                UnauthorizedException => (int)HttpStatusCode.Unauthorized, // 401
                NotFoundException => (int)HttpStatusCode.NotFound,         // 404
                _ => (int)HttpStatusCode.InternalServerError               // 500 (For unexpected crashes)
            };
            context.Response.StatusCode = statusCode;

            // Build  JSON response for the frontend

            var response = new
            {
                StatusCode = statusCode,
                Message = exception.Message,

                // Only show the messy stack trace if it's a critical 500 crash

                Details = statusCode == 500 ? exception.StackTrace?.ToString() : null
            };
            var jsonResponse = JsonSerializer.Serialize(response);
            return context.Response.WriteAsync(jsonResponse);
        }
    }
}
