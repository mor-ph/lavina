using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AutoMapper;
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
        private readonly IMapper _mapper;

        private ICommentsRepository CommentRepo { get; set; }

        public CommentController(ICommentsRepository _repo,IMapper mapper)
        {
            CommentRepo = _repo;
            _mapper = mapper;
        }

        // GET: /Comment
        [HttpGet]
        [Route("/Comments")]
        public async Task<IActionResult> GetAllAsync()
        {
            var commentsList = await CommentRepo.GetAll();
            var commentsToReturn = _mapper.Map<IEnumerable<CommentDto>>(commentsList);
            return Ok(commentsToReturn);
        }
        //GET: api/comment/1
        [HttpGet("{id}")]
        public async Task<IActionResult> GetCommentsByEventId(int id)
        {
            var comments = await CommentRepo.GetCommentsForEvent(id);
            var commentsToReturn = _mapper.Map<IEnumerable<CommentDto>>(comments);
            return Ok(commentsToReturn);
        }

        [HttpPost]
        [Authorize] //use jwt token
        [Route("/Comments")]
        public async Task<IActionResult> Create([FromBody] CommentViewModel item)
        {           
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
            var lastComment = _mapper.Map<CommentDto>(cm);
            return Ok(lastComment);
        }
    }
}
