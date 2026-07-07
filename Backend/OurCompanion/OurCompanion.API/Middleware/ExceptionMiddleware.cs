using Microsoft.AspNetCore.Http.HttpResults;
using OurCompanion.Application.Common.Exceptions;
using OurCompanion.Application.Common.Models;
using System.Net;
using System.Text.Json;

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
                AlreadyExistException => (int)HttpStatusCode.Conflict,       // 409
                BadRequestException => (int)HttpStatusCode.BadRequest,      // 400
                _ => (int)HttpStatusCode.InternalServerError               // 500 (For unexpected crashes)
            };
            context.Response.StatusCode = statusCode;

            // Build  JSON response for the frontend

            var response = ApiResponse<object>.FailureResponse(
                message: exception.Message,
                errors: statusCode == (int)HttpStatusCode.InternalServerError
                ? new List<string> { exception.StackTrace ?? "An unexpected error occurred." }
                : null
                );
            
            var jsonResponse = JsonSerializer.Serialize(response);
            return context.Response.WriteAsync(jsonResponse);
        }
    }
}
