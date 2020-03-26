using EventAPI.Models.Models;
using EventAPI.Models.QueryParameters;
using EventAPI.Models.ViewModels;
using EventAPI.Models.ViewModels.Events;
using EventAPI.Models.ViewModels.UserEvents;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace EventAPI.Services.EventService
{
    public interface IEventService
    {
        Task<IEnumerable<EventsForListViewModel>> GetAllEvents(EventsQueryParameters parameters);
        Task CreateEvent(EventInputModel ev);
        Task<Event> UpdateEvent(int id, EventUpdateModel model);
        Task DeleteEvent(int id);
        Task<EventDetailsViewModel> GetEventByID(int id);
        Task<Category> GetCategory(string name);
        Task<City> GetCity(string name);
        Task<CreatedAndJoinedEventDto> GetCreatedAndJoinedEvents();
        Task<bool> EventExists(EventInputModel model);
    }
}
