using EventAPI.Models.Models;
using EventAPI.Models.ViewModels;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace EventAPI.Services.UserEventService
{
    public interface IUserEventService
    {
        Task AddUserEvent(UserEventAddViewModel userevent);

        Task<IEnumerable<UserEventViewModel>> GetUsersEvents();

        Task<User> GetUser(int id);
        Task<Userevent> GetUserEvent(UserEventAddViewModel userevent);
    }
}
