using System;
using System.Collections.Generic;

namespace EventAPI.Models.Models
{
    public partial class Userevent
    {
        public int UserId { get; set; }
        public int EventId { get; set; }

        public virtual Event Event { get; set; }
    }
}
