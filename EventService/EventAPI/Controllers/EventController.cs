using AutoMapper;
using EventAPI.Data.Context;
using EventAPI.Models.Models;
using EventAPI.Models.QueryParameters;
using EventAPI.Models.ViewModels;
using EventAPI.Models.ViewModels.Events;
using EventAPI.Services.EventService;
using EventAPI.Services.UserEventService;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

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
        private readonly IUserEventService _userEventService;

        public EventController(LetsPlayDbContext dbContext, IEventService eventService,
            IMapper mapper, IUserEventService userEventService)
        {
            _dbContext = dbContext;
            _eventService = eventService;
            _mapper = mapper;
            _userEventService = userEventService;
        }

        //GET: api/event
        [HttpGet()]
        public async Task<IActionResult> GetAll([FromQuery] EventsQueryParameters eventsQueryParameters)
        {
            var events = await _eventService.GetAllEvents(eventsQueryParameters);
            return Ok(events);

        }
        //GET: api/event/id
        [HttpGet("{id}")]
        public async Task<ActionResult<Event>> GetEventById(int id)
        {
            var dbEvent = await _eventService.GetEventByID(id);

            if (dbEvent != null)
            {
                return Ok(dbEvent);
            }
            else return NotFound();
        }


        // POST: api/event
        [HttpPost()]
        public async Task<ActionResult<Event>> CreateEvent([FromBody] EventInputModel model)
        {
            if (ModelState.IsValid)
            {
                if (await _eventService.GetCategory(model.Category) == null ||
                    await _eventService.GetCity(model.City) == null)
                    return BadRequest("City or Category is incorrect!");

                int userId;
                if (!int.TryParse(User.Claims.FirstOrDefault(x => x.Type == "userId").Value.ToString(), out userId))
                {
                    return BadRequest("Invalid EventCreatedByID");
                }
                if (await _eventService.EventExists(model))
                {
                    return BadRequest("This event was added recently.");
                }
                //Add event to database and save context
                await _eventService.CreateEvent(model);
                return StatusCode(201,"Event created.");
        }
            else
                return BadRequest("Invalid data");


    }

        // PUT: api/event/id
        [HttpPut("{id}")]
        public async Task<IActionResult> UpdateEventById(int id, [FromBody]EventUpdateModel model)
        {
            if (ModelState.IsValid)
            {
                var updatedEvent = await _eventService.UpdateEvent(id, model);
                if (updatedEvent != null)
                    return this.Ok(updatedEvent);
                else
                    return this.BadRequest("Invalid ID");
            }
            else return this.BadRequest();

        }

        // DELETE: api/event/id
        [HttpDelete("{id}")]
        public async Task<ActionResult> Delete(int id)
        {
            var evt = await _eventService.GetEventByID(id);
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
        // GET: api/event/userevents
        [HttpGet("userevents")]
        public async Task<IActionResult> GetUserEvents()
        {
            var userEvents = await _userEventService.GetUsersEvents();

            return Ok(userEvents);
        }
        // POST: api/event/userevents
        [HttpPost("userevents")]
        public async Task<IActionResult> PostUserEvents([FromBody] UserEventAddViewModel userEvent)
        {
            var user = await _dbContext.Users.FirstOrDefaultAsync(c => c.Id == userEvent.UserId);
            var Event = await _dbContext.Events.FirstOrDefaultAsync(c => c.Id == userEvent.EventId);
            if (user == null || Event == null)
            {
                return BadRequest("No such user or event");
            }
            Userevent userevent = new Userevent();
            userevent.EventId = userEvent.EventId;
            userevent.UserId = userEvent.UserId;
            if (await _dbContext.Userevent.FindAsync(userevent.UserId, userevent.EventId) != null)
            {
                return BadRequest("Already joined event");
            }
            _dbContext.Userevent.Add(userevent);
            await _dbContext.SaveChangesAsync();

            return StatusCode(201, "Successfully joined event");
        }
        [HttpGet("da")]
        public async Task<IActionResult> GetEventsForLoggedUser()
        {
            var events = await _eventService.GetCreatedAndJoinedEvents();
            return Ok(events);
        }

    }
}