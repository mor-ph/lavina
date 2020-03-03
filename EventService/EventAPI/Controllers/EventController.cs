using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Text.Json;
using System.Threading.Tasks;
using AutoMapper;
using EventAPI.Data.Context;
using EventAPI.Models;
using EventAPI.Models.Models;
using EventAPI.Models.ViewModels;
using EventAPI.Services.Categories;
using EventAPI.Services.EventService;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace EventAPI.Controllers
{
     

    [Route("api/[controller]")]
    [ApiController]
    [Authorize]
    
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
        public async Task<IEnumerable<Event>> GetAll()
        {
            return await _eventService.GetAllEvents();
            
        }
        //Get event/get/id
        [HttpGet("get/{id}")]
        public async Task<ActionResult<Event>> GetEventById(int id)
        {
            var dbEvent = await _eventService.GetEventByID(id);

            if (dbEvent != null)
            {
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
                    return BadRequest("City or Category is null");

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
                if (model.Recurring == null)
                {
                    evt.Recurring = null;
                }
                else 
                    evt.Recurring = (int)model.Recurring;



                //Add event to database and save context
                await _eventService.CreateEvent(evt);
                return this.Ok("Event successfuly created");
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
                bool result = await _eventService.UpdateEvent(id, model);
                if(result)
                     return this.Ok("Event successully updated!");
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

    }
}