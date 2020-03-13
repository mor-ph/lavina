using EventAPI.Data.Context;
using EventAPI.Models.Enums;
using EventAPI.Models.Models;
using EventAPI.Models.QueryParameters;
using EventAPI.Models.ViewModels;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Globalization;
using System.Linq;
using System.Linq.Expressions;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;
using AutoMapper;

namespace EventAPI.Services.EventService
{
    public class EventService : IEventService
    {
        private readonly LetsPlayDbContext _dbContext;
        private readonly IMapper _mapper;

        public EventService (LetsPlayDbContext dbContext, IMapper mapper)
        {
            _dbContext = dbContext;
            _mapper = mapper;
        }

        public async Task CreateEvent(Event ev)
        {
            await _dbContext.Events.AddAsync(ev);
            await _dbContext.SaveChangesAsync();
        }

        public async Task DeleteEvent(Event evt)
        {
            _dbContext.Events.Remove(evt);
            await _dbContext.SaveChangesAsync();
        }

        public async Task<IEnumerable<Event>> GetAllEvents(EventsQueryParameters parameters)
        {
            List<Event> events;
            if(AreAllNullOrEmpty(parameters) == false)
            {
                            events = await _dbContext.Events
                .Include(e => e.City)
                .Include(e => e.Category).ToListAsync();
                if(parameters.Category != null)
                {
                    var category = _dbContext.Categories.FirstOrDefault(c => c.Name == parameters.Category);
                    events = events.Where(e => e.Category.Id == category.Id || e.Category.ParentCategoryId == category.Id).ToList();
                }
                if(parameters.SubCategory!= null)
                {
                    events = events.Where(e => e.Category.Name == parameters.SubCategory).ToList();
                }
                if(parameters.Location != null)
                {
                    events = events.Where(e => e.City.Name == parameters.Location).ToList();
                }
                if (parameters.Date != null)
                {
                    events = events.Where(e => e.EventStartDate.Date == parameters.Date.Value.Date).ToList();
                }



                return events;
            }  
            events = await _dbContext.Events
                .Include(e => e.City)
                .Include(e => e.User)
                .Include(e => e.Category)
                .Include(e => e.Userevent)
                .OrderByDescending(x => x.CreatedOn)
                .Take(48)
                .AsNoTracking()
                .ToListAsync();


            return events;
            
        }
        private bool AreAllNullOrEmpty(object myObject)
        {
            int count = 0;
            foreach (PropertyInfo pi in myObject.GetType().GetProperties())
            {

                if(pi.GetValue(myObject) == null)
                {
                    count++;
                }
            }
            if(count==myObject.GetType().GetProperties().Count())
            {
                return true;
            }
            return false;
        }
        public async Task<Event> GetEventByID(int id)
        {
            return await _dbContext.Events
                .Include(e => e.Category)
                .Include(e => e.City)
                .Include(e => e.User)
                .FirstOrDefaultAsync(e => e.Id==id);
        }

        public async Task<Event> UpdateEvent(int id, EventUpdateModel model)
        {
            var dbEvent = await _dbContext.Events.FirstOrDefaultAsync(x => x.Id == id);
            // var category = await _dbContext.Categories.FirstOrDefaultAsync(c => c.Name == model.Category);
            // var city = await _dbContext.Cities.FirstOrDefaultAsync(c => c.Name == model.City);
            // if (dbEvent == null || category == null || city == null)
            //     return null;
            //
            // dbEvent.Title = model.Title;
            // dbEvent.Description = model.Description;
            // dbEvent.EventStartDate = model.EventStartDate;
            // dbEvent.PeopleNeeded = model.PeopleNeeded;
            // dbEvent.UpdatedOn = DateTime.UtcNow;
            // dbEvent.EventStatus = (int)model.EventStatus;
            // dbEvent.Address = model.Address;
            // dbEvent.Category = category;
            // dbEvent.City = city;
            // dbEvent.Recurring = (int)model.Recurring;
            dbEvent.PeopleNeeded = model.PeopleNeeded;
            dbEvent.EventStatus = (int)model.EventStatus;
            dbEvent.UpdatedOn = DateTime.UtcNow;
            
            await _dbContext.SaveChangesAsync();
            return dbEvent;




        }
    }
}
