using AutoMapper;
using EventAPI.Models.Models;
using EventAPI.Models.ViewModels;
using EventAPI.Models.ViewModels.Categories;
using EventAPI.Models.ViewModels.Cities;
using EventAPI.Models.ViewModels.Events;

namespace EventAPI.Models.Helpers
{
    public class MappingProfile : Profile
    {
        public MappingProfile()
        {
            CreateMap<Category, MainCategoriesViewModel>();
            CreateMap<Category, SubCategoriesViewModel>();
            CreateMap<CategoriesAddViewModel, Category>();

            CreateMap<Event, EventInputModel>();
            CreateMap<EventInputModel, Event>()
                .ForMember(dest => dest.City, opt => opt.Ignore())
                .ForMember(dest => dest.Category, opt => opt.Ignore());
            CreateMap<EventUpdateModel, Event>();
            CreateMap<Event, EventsForListViewModel>()
                .ForMember(dest => dest.IsActive,
                 opt => opt.MapFrom(src => src.EventStartDate.IsEventActive()))
                .ForMember(dest => dest.EventStatus,
                 opt => opt.MapFrom(src => src.EventStatus.EventStatusConvert()))
                .ForMember(dest => dest.AddedAgo,
                opt => opt.MapFrom(src => src.CreatedOn.TimeAgo()));
            CreateMap<City, CityViewModel>();
            CreateMap<User, UserViewModel>();

            CreateMap<UserEventAddViewModel, Userevent>();
        }
    }
}
