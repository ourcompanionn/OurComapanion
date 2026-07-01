using AutoMapper;
using OurCompanion.Application.DTOs.Auth;
using OurCompanion.Domain.Entities;

namespace OurCompanion.Application.Mappings;

public class AuthMappingProfile : Profile
{
    public AuthMappingProfile()
    {
        CreateMap<RegisterUserDto, Account>()

          // only hardcode backend SECURITY fields that the frontend isn't allowed to send:
          .ForMember(dest => dest.IsVerified, opt => opt.MapFrom(src => true)) // verified instantly
            .ForMember(dest => dest.IsProfileCompleted, opt => opt.MapFrom(src => false))
            .ForMember(dest => dest.IsActive, opt => opt.MapFrom(src => true))
            .ForMember(dest => dest.CreatedAt, opt => opt.MapFrom(src => DateTime.UtcNow));

        // Add mapping for Entity -> DTO
        CreateMap<Account, OurCompanion.Application.DTOs.Account.AccountDto>();
    }
}
