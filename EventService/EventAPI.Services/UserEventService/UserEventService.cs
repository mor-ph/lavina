using AutoMapper;
using EventAPI.Data.Context;
using EventAPI.Models.Models;
using EventAPI.Models.ViewModels;
using EventAPI.Models.ViewModels.Events;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace EventAPI.Services.UserEventService
{
    public class UserEventService : IUserEventService
    {
        private readonly LetsPlayDbContext _context;
        private readonly IMapper _mapper;

        public UserEventService(LetsPlayDbContext context,IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }
        public async Task AddUserEvent(UserEventAddViewModel userevent)
        {
            var userEvent = _mapper.Map<Userevent>(userevent);

            await _context.Userevent.AddAsync(userEvent);
            await _context.SaveChangesAsync();
        }

        public async Task<User> GetUser(int id)
        {
            return await _context.Users.FirstOrDefaultAsync(c => c.Id == id);
        }

        public async Task<Userevent> GetUserEvent(UserEventAddViewModel userevent)
        {
            var userEvent = _mapper.Map<Userevent>(userevent);
            return await _context.Userevent.FindAsync(userEvent.EventId, userEvent.UserId);
        }

        public async Task<IEnumerable<UserEventViewModel>> GetUsersEvents()
        {
            List<UserEventViewModel> userEvent = new List<UserEventViewModel>();
            foreach (var item in await _context.Userevent.ToListAsync())
            {
                var user = await _context.Users.FirstOrDefaultAsync(u => u.Id == item.UserId);

                var userToReturn = _mapper.Map<UserViewModel>(user);

                var Event = await _context.Events
                    .Include(e => e.City)
                    .Include(e => e.Category)
                    .Include(e => e.User)
                    .FirstOrDefaultAsync(e => e.Id == item.EventId);
                var eventToReturn = _mapper.Map<EventsForListViewModel>(Event);

                userEvent.Add(new UserEventViewModel(userToReturn, eventToReturn));
            }
            return userEvent;
        }
    }
}
