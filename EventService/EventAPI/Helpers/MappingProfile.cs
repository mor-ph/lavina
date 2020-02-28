﻿using AutoMapper;
using EventAPI.Models.Models;
using EventAPI.Models.ViewModels;
using EventAPI.Models.ViewModels.Categories;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EventAPI.Helpers
{
    public class MappingProfile : Profile
    {
        public MappingProfile()
        {
            CreateMap<Category, MainCategoriesViewModel>();
            CreateMap<Category, SubCategoriesViewModel>();
            CreateMap<CategoriesAddViewModel, Category>();
            CreateMap<Event, EventInputModel>();
        }
    }
}