using AutoMapper;
using OurCompanion.Application.DTOs.Category;
using OurCompanion.Application.DTOs.UserProfile;
using OurCompanion.Domain.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OurCompanion.Application.Mappings
{
    public class UserProfileMappingProfile : Profile
    {
        public UserProfileMappingProfile()
        {
            // Category → CategoryDto
            CreateMap<Categories, CategoryDto>();

            // UserProfiles → UserProfileDto
            // FirstName, LastName, PhoneNumber, Categories
            // come from different tables so we ignore them here
            // and set them manually in the service
            CreateMap<UserProfiles, UserProfileDto>()
                .ForMember(dest => dest.FirstName,
                    opt => opt.Ignore())
                .ForMember(dest => dest.LastName,
                    opt => opt.Ignore())
                .ForMember(dest => dest.PhoneNumber,
                    opt => opt.Ignore())
                .ForMember(dest => dest.Categories,
                    opt => opt.Ignore());

            // UserFiles → UserFileDto
            CreateMap<UserFiles, UserFileDto>();
        }
    }
}
