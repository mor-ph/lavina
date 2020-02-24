using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Text.Json;
using System.Threading.Tasks;
using EventAPI.Models;
using EventAPI.Models.EventInputModel;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace EventAPI.Controllers
{
     

    [Route("api/[controller]")]
    [ApiController]
    public class EventController : ControllerBase
    {
        //Database 
        public static List<Event> events = new List<Event> { new Event { ID = 0 }, new Event { ID = 1 } };

        //returns events in json format
        [HttpGet("getall")]
        public string GetAll()
        {
            var jsonResult = JsonSerializer.Serialize(events);

            return jsonResult;
        }
        //Get event/get/id
        [HttpGet("get/{id}")]
        public string GetEventById(int id)
        {
            var dbEvent = events.FirstOrDefault(x => x.ID == id);

            if (dbEvent != null)
            {
                var jsonEvent = JsonSerializer.Serialize(dbEvent);
                return jsonEvent;

            }
            else return new string($"No event with id = {id}");
        }


        // POST: api/event/create
        [HttpPost("create")]
        public IActionResult CreateEvent([FromBody] EventInputModel model)
        {
            if (ModelState.IsValid)
            {
                var evt = new Event()
                {
                    ID = model.ID,
                    Title = model.Title,
                    CreatedBy = model.CreatedBy,
                    Description = model.Description,
                    EventStartDate = model.EventStartDate,
                    PeopleNeeded = model.PeopleNeeded,
                    Location = model.Location,
                    EventStatus = model.EventStatus,
                    //UpdatedOn = model.UpdatedOn,
                    //CreatedOn = model.CreatedOn,

                };
                //Add event to database and save context
                events.Add(evt);
                return this.Ok("Event successfuly created");
            }
            else
                return this.BadRequest("Invalid data");



        }

        // PUT: api/event/update/id
        [HttpPut("update/{id}")]
        public IActionResult UpdateEventById(int id, EventInputModel model)
        {
            var dbEvent = events.FirstOrDefault(x => x.ID == id);
            if (dbEvent != null && ModelState.IsValid)
            {
                dbEvent.Title = model.Title;
                dbEvent.CreatedBy = model.CreatedBy;
                dbEvent.Description = model.Description;
                dbEvent.EventStartDate = model.EventStartDate;
                dbEvent.PeopleNeeded = model.PeopleNeeded;
                dbEvent.Location = model.Location;
                dbEvent.UpdatedOn = DateTime.UtcNow;
                dbEvent.EventStatus = model.EventStatus;
                
                return this.Ok("Event successully updated!");

            }
            else return this.BadRequest($"Not event with id = {id}");

        }

        // DELETE: api/event/delete/id
        [HttpDelete("delete/{id}")]
        public IActionResult Delete(int id)
        {
            var dbEvent = events.FirstOrDefault(x => x.ID == id);
            if (dbEvent != null)
            {
                events.Remove(dbEvent);

                return this.Ok("Event successfully deleted!");
            }
            else return this.BadRequest($"no event with id = {id}");
        }




    }
}