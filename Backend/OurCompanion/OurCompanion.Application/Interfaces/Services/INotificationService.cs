using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace OurCompanion.Application.Interfaces.Services
{
    public interface INotificationService
    {
        //send otp
        Task SendOtpAsync(string? email, string? phoneNumber, string otpCode);
    }
}
