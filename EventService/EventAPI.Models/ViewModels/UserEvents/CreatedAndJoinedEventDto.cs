using EventAPI.Models.ViewModels.Events;
using System.Collections.Generic;

namespace EventAPI.Models.ViewModels.UserEvents
{
    public class CreatedAndJoinedEventDto
    {
        public ICollection<EventsForListViewModel> JoinedEvents { get; set; }
        public ICollection<EventsForListViewModel> CreatedEvents { get; set; }
    }
}
