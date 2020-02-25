using EventAPI.Data.Context;
using EventAPI.Models.Models;
using EventAPI.Models.ViewModels;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
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

        public async Task<IEnumerable<Event>> GetAllEvents()
        {
            return await _dbContext.Events.OrderByDescending(x=>x.CreatedOn).ToListAsync();
            
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

            await _dbContext.SaveChangesAsync();
            return true;

        }
    }
}
