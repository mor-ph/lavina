using EventAPI.Data.Context;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Threading.Tasks;

namespace EventAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class LocationController : ControllerBase
    {
        private readonly LetsPlayDbContext _context;

        public LocationController(LetsPlayDbContext context)
        {
            _context = context;
        }
        [HttpGet]
        public async Task<IActionResult> GetAllLocations()
        {
            var locations = await _context.Cities.ToListAsync();

            return Ok(locations);
        }
    }
}