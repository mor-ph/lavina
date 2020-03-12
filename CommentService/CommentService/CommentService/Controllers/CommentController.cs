using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using CommentService.Data;
using CommentService.Models;
using CommentService.Repository;
using CommentService.ViewModels;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace CommentService.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CommentController : ControllerBase
    {
        private ICommentsRepository CommentRepo { get; set; }

        public CommentController(ICommentsRepository _repo)
        {
            CommentRepo = _repo;
        }

        // GET: /Comment
        [HttpGet]
        [Route("/Comments")]
        public async Task<IActionResult> GetAllAsync()
        {
            var commentsList = await CommentRepo.GetAll();
            return Ok(commentsList);
        }

        //GET: api/Comment/5
        //[HttpGet("{id}", Name = "GetComments")]
        //public async Task<IActionResult> Get(int id)
        //{
        //    return "value";
        //}
        //GET: api/comment/1
        [HttpGet("{id}")]
        public async Task<IActionResult> GetCommentsByEventId(int id)
        {
            var comments = await CommentRepo.GetCommentsForEvent(id);
            return Ok(comments);
        }

        [HttpPost]
        [Authorize] //use jwt token
        [Route("/Comments")]
        public async Task<IActionResult> Create([FromBody] CommentViewModel item)
        {           
            if (!ModelState.IsValid)
            {
                return BadRequest();
            }

            int userId;
            if (!int.TryParse(User.Claims.FirstOrDefault(x => x.Type == "userId").Value.ToString(), out userId))
            {
                return this.BadRequest("Invalid UserId");
            }

            Comment cm = item;
            cm.UserId = userId;
            cm.PostedOn = DateTime.Now;

            // // Real solution
            await CommentRepo.Add(cm);
            return Ok(await CommentRepo.GetAll());
        }

        // PUT: api/Comment/5
        //[HttpPut("{id}")]
        //public void Put(int id, [FromBody] string value)
        //{
        //}

        //// DELETE: api/ApiWithActions/5
        //[HttpDelete("{id}")]
        //public void Delete(int id)
        //{
        //}
    }
}
