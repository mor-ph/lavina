using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace EventAPI.Validations
{
    public class DateValidation : RangeAttribute
    {
        public DateValidation()
          : base(typeof(DateTime), DateTime.Now.AddYears(-20).ToShortDateString(), DateTime.Now.AddYears(2).ToShortDateString()) { }
    }
}
