using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;
using System;
using System.Collections.Generic;
using System.Net;
using System.Net.Http;
using System.Text;

namespace EventAPI.Models.Validations
{
    public class ValidateModel : ActionFilterAttribute
    {
        public override void OnActionExecuting(ActionExecutingContext context)
        {
            if (!context.ModelState.IsValid)
            {
                if (context.ModelState.ContainsKey("EventStartDate"))
                {
                    context.Result = new BadRequestObjectResult("Date must be in the future");
                }
                else
                context.Result = new BadRequestObjectResult(context.ModelState);
            }
        }
    }
    
}
