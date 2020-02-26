using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using CommentService.Models;
using CommentService.Repository;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace CommentService.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CommentController : ControllerBase
    {
        public ICommentsRepository CommentRepo { get; set; }

        public CommentController(ICommentsRepository _repo)
        {
            CommentRepo = _repo;
        }

        // GET: /Comment
        [HttpGet]
        [Route("/Comments")]
        public async Task<IActionResult> GetAll()
        {
            List<Comment> comments = new List<Comment>();

            comments.Add(new Comment
            {
                Id = 1,
                EventId = 1,
                UserId = 1,
                Message = "Some message",
            });


            return Ok(comments);


            //var commentsList = await CommentRepo.GetAll();
            //return Ok(commentsList);
        }

        // GET: api/Comment/5
       //[HttpGet("{id}", Name = "GetComments")]
       //public async Task<IActionResult> Get(int id)
       // {

       //     return "value";
       // }

        // POST: /Comment
        [HttpPost]
        [Route("/Comments")]
        public async Task<IActionResult> Create([FromBody] Comment item)
            {
            /// TODO
            /// Check if user is authenticated from JAVA WEB API
            /// 
           

            if (!ModelState.IsValid)
            {
                return BadRequest();
            }

            //Test
            List<Comment> comments = new List<Comment>();
            comments.Add(item);
            
            //// check if this comment already exist
            //var commentExist = comments.FirstOrDefault(c => c.Id == item.Id);

            // Real solution
           await CommentRepo.Add(item);
            return CreatedAtRoute("GetAll", new { Controller = "Comment", id = item.Id }, item);

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
