using EventAPI.Models.Models;
using EventAPI.Models.ViewModels;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace EventAPI.Services.UserEventService
{
    public interface IUserEventService
    {
        Task AddUserEvent(UserEventAddViewModel userevent);

        Task<IEnumerable<UserEventViewModel>> GetUsersEvents();

        Task<User> GetUser(int id);
        Task<Userevent> GetUserEvent(UserEventAddViewModel userevent);
        Task<Event> GetEvent(int id);
    }
}
