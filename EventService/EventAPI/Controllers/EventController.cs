using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Text.Json;
using System.Threading.Tasks;
using AutoMapper;
using EventAPI.Data.Context;
using EventAPI.Models;
using EventAPI.Models.Enums;
using EventAPI.Models.Models;
using EventAPI.Models.QueryParameters;
using EventAPI.Models.ViewModels;
using EventAPI.Models.ViewModels.Events;
using EventAPI.Services.Categories;
using EventAPI.Services.EventService;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json;

namespace EventAPI.Controllers
{
     

    [Route("api/[controller]")]
    [ApiController]
    // [Authorize]
    
    public class EventController : ControllerBase
    {
        //Database 
        private readonly LetsPlayDbContext _dbContext;
        private readonly IEventService _eventService;
        private readonly IMapper _mapper;

        public EventController(LetsPlayDbContext dbContext,IEventService eventService, IMapper mapper)
        {

            _dbContext = dbContext;
            _eventService = eventService;
            _mapper = mapper;
        }


        //returns events in json format
        [HttpGet("getall")]
        public async Task<IActionResult> GetAll([FromQuery] EventsQueryParameters eventsQueryParameters)
        {
            
            var events = await _eventService.GetAllEvents(eventsQueryParameters);
            var eventsToReturn = _mapper.Map<List<EventsForListViewModel>>(events);

            //eventsToReturn.ForEach(e => e.EventStatus = (Status)Enum.Parse(typeof(Status), e.EventStatus.ToString()));
            return Ok(eventsToReturn);
            
        }
        //Get event/get/id
        [HttpGet("get/{id}")]
        public async Task<ActionResult<Event>> GetEventById(int id)
        {
            var dbEvent = await _eventService.GetEventByID(id);

            if (dbEvent != null)
            {
                List<Comment> comments;
                using (var httpClient = new HttpClient())
                {
                    using (var response = await httpClient.GetAsync("http://172.27.0.1:5101/api/comment/" + id))
                    {
                        string apiResponse = await response.Content.ReadAsStringAsync();
                        comments = JsonConvert.DeserializeObject<List<Comment>>(apiResponse);
                        dbEvent.Comments = comments;
                    }
                }
                return dbEvent;

            }
            else return NotFound();
        }


        // POST: api/event/create
        [HttpPost("create")]
        public async Task<ActionResult<Event>> CreateEvent([FromBody] EventInputModel model)     
        {
            if (ModelState.IsValid)
            {
                var category = await _dbContext.Categories.FirstOrDefaultAsync(c => c.Name == model.Category);
                var city = await _dbContext.Cities.FirstOrDefaultAsync(c => c.Name == model.City);
                if (category == null || city == null)
                    return BadRequest("City or Category is incorrect!");

                int userId;
                if (!int.TryParse(User.Claims.FirstOrDefault(x => x.Type == "userId").Value.ToString(), out userId))
                {
                    return this.BadRequest("Invalid EventCreatedByID");
                }
                var evt = new Event()
                {
                    Title = model.Title,
                    UserCreatedById = userId,
                    Description = model.Description,
                    EventStartDate = model.EventStartDate,
                    PeopleNeeded = model.PeopleNeeded,
                    Category = category,
                    City = city,
                    EventStatus = (int)model.EventStatus,
                    Address = model.Address,
                    CreatedOn = DateTime.UtcNow,
                    UpdatedOn = DateTime.UtcNow,

                };

                var dbEvents = await _dbContext.Events.Where(
                   x => x.UserCreatedById == evt.UserCreatedById &&
                   x.Title == evt.Title &&
                   x.CategoryId == category.Id).ToListAsync();
                
                var result = dbEvents.Any(x => Math.Abs((evt.EventStartDate - x.EventStartDate).TotalHours) < 1);


                if (result)
                {
                    return BadRequest("Event already exists");
                }
                if (model.Recurring == null)
                {
                    evt.Recurring = null;
                }
                else
                    evt.Recurring = (int)model.Recurring;



                //Add event to database and save context
                await _eventService.CreateEvent(evt);
                return this.Ok(evt);
            }
            else
                return this.BadRequest("Invalid data");


        }

        // PUT: api/event/update/id
        [HttpPut("update/{id}")]
        public async Task<IActionResult> UpdateEventById(int id, [FromBody]EventInputModel model)
        {
            
            if (ModelState.IsValid)
            {
                var updatedEvent = await _eventService.UpdateEvent(id, model);
                if(updatedEvent != null)
                     return this.Ok(updatedEvent);
                else
                     return this.BadRequest();

            }
            else return this.BadRequest();

        }

        // DELETE: api/event/delete/id
        [HttpDelete("delete/{id}")]
        public async Task<ActionResult> Delete(int id)
        {
            var evt = await _dbContext.Events.FindAsync(id);
            if (evt == null)
            {
                return NotFound();
            }
            else
            {
                await _eventService.DeleteEvent(evt);
                return this.Ok("Event successfully deleted!");


            }
        }
        [HttpGet("userevents")]
        public async Task<IActionResult> GetUserEvents()
        {
            List<UserEventViewModel> userEvent = new List<UserEventViewModel>();
            foreach (var item in await _dbContext.Userevent.ToListAsync())
            {
                var user = await _dbContext.Users.FirstOrDefaultAsync(u => u.Id==item.UserId);

                var userToReturn = _mapper.Map<UserViewModel>(user);

                var Event = await _dbContext.Events
                    .Include(e => e.City)
                    .Include(e => e.Category)
                    .Include(e => e.User)
                    .FirstOrDefaultAsync(e => e.Id == item.EventId);
                var eventToReturn = _mapper.Map<EventsForListViewModel>(Event);

                userEvent.Add(new UserEventViewModel(userToReturn,eventToReturn));
            }

            return Ok(userEvent);
        }
        [HttpPost("userevents")]
        public async Task<IActionResult> PostUserEvents([FromBody] UserEventAddViewModel userEvent)
        {
            var user = await _dbContext.Users.FirstOrDefaultAsync(c => c.Id == userEvent.UserId);
            var Event = await _dbContext.Events.FirstOrDefaultAsync(c => c.Id == userEvent.EventId);
            if(user == null || Event == null)
            {
                return BadRequest("No such user or event");
            }
            Userevent userevent = new Userevent();
            userevent.EventId = userEvent.EventId;
            userevent.UserId = userEvent.UserId;
            if(await _dbContext.Userevent.FindAsync(userevent.UserId,userevent.EventId) != null)
            {
                return BadRequest("Already joined event");
            }
            _dbContext.Userevent.Add(userevent);
            await _dbContext.SaveChangesAsync();

            return StatusCode(201, "Successfully joined event");
        }

    }
}