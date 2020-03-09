using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using EventAPI.Data.Context;
using Microsoft.AspNetCore.Cors;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace EventAPI.Controllers
{
    [EnableCors("AllowAnyOrigin")]
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