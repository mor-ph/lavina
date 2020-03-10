using EventAPI.Data.Context;
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

namespace EventAPI.Services.EventService
{
    public class EventService : IEventService
    {
        private readonly LetsPlayDbContext _dbContext;

        public EventService (LetsPlayDbContext dbContext)
        {
            _dbContext = dbContext;
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
            //if(parameters.Date.HasValue)
            //{
            //    string s = parameters.Date.Value.Date.ToString("dd/MM/yyyy");
            //    parameters.Date = DateTime.ParseExact(s, "d",CultureInfo.CurrentCulture);
            //}
            List<Event> events;
            if(IsAnyNullOrEmpty(parameters) == false)
            {
                            events = await _dbContext.Events
                .Include(e => e.City)
                .Include(e => e.Category)
                .Where(e => ((e.Category.Name == parameters.Category && parameters.SubCategory==null) ||
                            (e.Category.Name == parameters.SubCategory)) &&
                            (parameters.Location == null || e.City.Name == parameters.Location) &&
                            (parameters.Date == null || e.EventStartDate.Date == parameters.Date.Value.Date)) 
                .AsNoTracking()
                .ToListAsync();
                return events;
            }  

            events = await _dbContext.Events
                .Include(e => e.City)
                .OrderByDescending(x => x.CreatedOn)
                .Take(48)
                .AsNoTracking()
                .ToListAsync();
            return events;
            
        }
        private bool IsAnyNullOrEmpty(object myObject)
        {
            foreach (PropertyInfo pi in myObject.GetType().GetProperties())
            {
                if (pi.PropertyType == typeof(string))
                {
                    string value = (string)pi.GetValue(myObject);
                    if (string.IsNullOrEmpty(value))
                    {
                        return true;
                    }
                }
            }
            return false;
        }
        public async Task<Event> GetEventByID(int id)
        {
            return await _dbContext.Events.FindAsync(id);
        }

        public async Task<bool> UpdateEvent(int id, EventInputModel model)
        {
            var dbEvent = await _dbContext.Events.FirstOrDefaultAsync(x => x.Id == id);
            var category = await _dbContext.Categories.FirstOrDefaultAsync(c => c.Name == model.Category);
            var city = await _dbContext.Cities.FirstOrDefaultAsync(c => c.Name == model.City);
            if (dbEvent == null || category == null || city == null)
                return false;

            dbEvent.Title = model.Title;
            dbEvent.Description = model.Description;
            dbEvent.EventStartDate = model.EventStartDate;
            dbEvent.PeopleNeeded = model.PeopleNeeded;
            dbEvent.UpdatedOn = DateTime.UtcNow;
            dbEvent.EventStatus = (int)model.EventStatus;
            dbEvent.Address = model.Address;
            dbEvent.Category = category;
            dbEvent.City = city;
            dbEvent.Recurring = (int)model.Recurring;
            await _dbContext.SaveChangesAsync();
            return true;

        }
    }
}
