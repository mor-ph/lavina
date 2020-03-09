using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace EventAPI.Models.Validations
{
    public class DateValidation : RangeAttribute
    {
        public DateValidation()
             : base(typeof(DateTime), DateTime.UtcNow.ToString(), DateTime.UtcNow.AddYears(2).ToString()) { }
    }
}
