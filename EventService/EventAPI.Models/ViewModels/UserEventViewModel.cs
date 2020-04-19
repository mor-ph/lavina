using EventAPI.Models.ViewModels.Events;

namespace EventAPI.Models.ViewModels
{
    public class UserEventViewModel
    {
        public UserEventViewModel(UserViewModel user, EventsForListViewModel events)
        {
            this.User = user;
            this.Event = events;
        }
        public UserViewModel User { get; set; }

        public EventsForListViewModel Event { get; set; }
    }
}
