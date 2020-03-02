using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using CommentService.Data;
using CommentService.Models;
using CommentService.Repository;
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


        [HttpPost]
        [Authorize] //use jwt token
        [Route("/Comments")]
        public async Task<IActionResult> Create([FromBody] Comment item)
            {           
            if (!ModelState.IsValid)
            {
                return BadRequest();
            }


            // check if this comment already exist
            //var commentExist = comments.FirstOrDefault(c => c.Id == item.Id);
            //return RedirectToAction("/Comments");

            // // Real solution
            await CommentRepo.Add(item);
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
