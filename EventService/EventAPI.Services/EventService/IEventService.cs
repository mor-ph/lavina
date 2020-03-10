using EventAPI.Models.Models;
using EventAPI.Models.QueryParameters;
using EventAPI.Models.ViewModels;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace EventAPI.Services.EventService
{
    public interface IEventService
    {
        Task<IEnumerable<Event>> GetAllEvents(EventsQueryParameters parameters);
        Task CreateEvent(Event ev);
        Task<bool> UpdateEvent(int id, EventInputModel model);
        Task DeleteEvent(Event evt);
        Task<Event> GetEventByID(int id);
    }
}
