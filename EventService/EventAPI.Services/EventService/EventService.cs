using AutoMapper;
using EventAPI.Data.Context;
using EventAPI.Models.Models;
using EventAPI.Models.QueryParameters;
using EventAPI.Models.ViewModels;
using EventAPI.Models.ViewModels.Categories;
using EventAPI.Models.ViewModels.Events;
using EventAPI.Models.ViewModels.UserEvents;
using Microsoft.AspNetCore.Http;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Reflection;
using System.Threading.Tasks;

namespace EventAPI.Services.EventService
{
    public class EventService : IEventService
    {
        private readonly LetsPlayDbContext _dbContext;
        private readonly IMapper _mapper;
        private readonly IHttpContextAccessor _httpContext;

        public EventService(LetsPlayDbContext dbContext, IMapper mapper, IHttpContextAccessor httpContext)
        {
            _dbContext = dbContext;
            _mapper = mapper;
            _httpContext = httpContext;
        }

        public async Task CreateEvent(EventInputModel ev)
        {
            var eventToSave = _mapper.Map<Event>(ev);
            if (ev.SubCategory == null)
            {
                eventToSave.Category = await GetCategory(ev.Category);
            }
            else
            {
                eventToSave.Category = await GetCategory(ev.SubCategory);
            }
            eventToSave.City = await GetCity(ev.City);
            eventToSave.UserCreatedById = GetCurrentUsersId();
            await _dbContext.Events.AddAsync(eventToSave);
            await _dbContext.SaveChangesAsync();
        }

        public async Task DeleteEvent(int id)
        {
            _dbContext.Events.Remove(_dbContext.Events.Find(id));
            await _dbContext.SaveChangesAsync();
        }

        public async Task<IEnumerable<EventsForListViewModel>> GetAllEvents(EventsQueryParameters parameters)
        {
            List<Event> events;
            if (AreAllNullOrEmpty(parameters) == false)
            {
                events = await _dbContext.Events
                    .Include(e => e.City)
                    .Include(e => e.Category)
                    .ToListAsync();
                if (parameters.Category != null)
                {
                    var category = _dbContext.Categories.FirstOrDefault(c => c.Name == parameters.Category);
                    events = events.Where(e => e.Category.Id == category.Id || e.Category.ParentCategoryId == category.Id).ToList();
                }
                if (parameters.SubCategory != null)
                {
                    events = events.Where(e => e.Category.Name == parameters.SubCategory).ToList();
                }
                if (parameters.Location != null)
                {
                    events = events.Where(e => e.City.Name == parameters.Location).ToList();
                }
                if (parameters.Date != null)
                {
                    events = events.Where(e => e.EventStartDate.Date == parameters.Date.Value.Date).ToList();
                }
            }
            else
            {
                events = await _dbContext.Events
                    .Include(e => e.City)
                    .Include(e => e.User)
                    .Include(e => e.Category)
                    .Include(e => e.Userevent)
                    .OrderByDescending(x => x.CreatedOn)
                    .Take(48)
                    .AsNoTracking()
                    .ToListAsync();
            }
            var eventsToReturn = _mapper.Map<List<EventsForListViewModel>>(events);
            return eventsToReturn;
        }
        public async Task<EventDetailsViewModel> GetEventByID(int id)
        {
            var eventDb = await _dbContext.Events
                .Include(e => e.Category)
                .Include(e => e.City)
                .Include(e => e.User)
                .Include(e => e.Userevent)
                .AsNoTracking()
                .FirstOrDefaultAsync(e => e.Id == id);
            List<Comment> comments;
            using (var httpClient = new HttpClient())
            {
                using (var response = await httpClient.GetAsync(@"http://commentapi:80/api/comment/" + id))
                {
                    string apiResponse = await response.Content.ReadAsStringAsync();
                    comments = JsonConvert.DeserializeObject<List<Comment>>(apiResponse);
                    eventDb.Comments = comments;
                }
            }
            var eventToReturn = _mapper.Map<EventDetailsViewModel>(eventDb);
            if(eventDb.Category.ParentCategoryId!=20)
            {
                eventToReturn.MainCategory = _mapper
                    .Map<MainCategoriesViewModel>(await GetCategory(_dbContext.Categories.FirstOrDefault(c => c.Id == eventDb.Category.ParentCategoryId).Name));
                eventToReturn.SubCategory = _mapper.Map<MainCategoriesViewModel>(eventDb.Category);
            }
            else
            {
                eventToReturn.MainCategory = _mapper.Map<MainCategoriesViewModel>(eventDb.Category);
            }
            return eventToReturn;
        }

        public async Task<Event> UpdateEvent(int id, EventUpdateModel model)
        {
            var dbEvent = await _dbContext.Events.FirstOrDefaultAsync(x => x.Id == id);
            //dbEvent.PeopleNeeded = model.PeopleNeeded;
            dbEvent.EventStatus = (int)model.EventStatus;
            dbEvent.UpdatedOn = DateTime.UtcNow;

            await _dbContext.SaveChangesAsync();
            return dbEvent;
        }
        public async Task<CreatedAndJoinedEventDto> GetCreatedAndJoinedEvents()
        {
            int userId = GetCurrentUsersId();

            var joinedEvents = await _dbContext.Userevent
                .Include(ue => ue.Event).ThenInclude(ue => ue.Category)
                .Include(ue => ue.Event).ThenInclude(ue => ue.City)
                .Include(ue => ue.Event).ThenInclude(ue => ue.User)
                .Where(ue => ue.UserId == userId).Select(ue => ue.Event).ToListAsync();

            var createdEvents = await _dbContext.Events
                .Include(ue => ue.City)
                .Include(ue => ue.Category)
                .Include(ue => ue.User)
                .Where(ue => ue.UserCreatedById == userId)
                .ToListAsync();

            return new CreatedAndJoinedEventDto
            {
                JoinedEvents = _mapper.Map<ICollection<EventsForListViewModel>>(joinedEvents),
                CreatedEvents = _mapper.Map<ICollection<EventsForListViewModel>>(createdEvents)
            };
        }

        public async Task<Category> GetCategory(string name)
        {
            return await _dbContext.Categories.FirstOrDefaultAsync(c => c.Name == name);
        }

        public async Task<City> GetCity(string name)
        {
            return await _dbContext.Cities.FirstOrDefaultAsync(c => c.Name == name);
        }

        public async Task<bool> EventExists(EventInputModel model)
        {
            var ev = await _dbContext.Events.Include(e => e.Category)
                 .Where(x => x.UserCreatedById == GetCurrentUsersId() &&
                        x.Title == model.Title &&
                        x.Category.Name == model.Category ||
                        x.Category.Name == model.SubCategory)
                 .ToListAsync();

            bool isDuplicate = ev.Any(x => Math.Abs((model.EventStartDate - x.EventStartDate).TotalHours) < 1);

            return isDuplicate;

        }
        private bool AreAllNullOrEmpty(object myObject)
        {
            int count = 0;
            foreach (PropertyInfo pi in myObject.GetType().GetProperties())
            {

                if (pi.GetValue(myObject) == null)
                {
                    count++;
                }
            }
            if (count == myObject.GetType().GetProperties().Count())
            {
                return true;
            }
            return false;
        }

        private int GetCurrentUsersId()
        {
            return int.Parse(_httpContext.HttpContext.User.Claims.FirstOrDefault(c => c.Type == "userId").Value);
        }
    }
}
