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
        Task<Userevent> AddUserEvent(UserEventAddViewModel userEvent);

        Task<IEnumerable<UserEventViewModel>> GetUsersEvents();
    }
}
