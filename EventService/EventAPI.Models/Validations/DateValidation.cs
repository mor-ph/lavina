using System;
using System.ComponentModel.DataAnnotations;

namespace EventAPI.Models.Validations
{
    public class DateValidation : RangeAttribute
    {
        public DateValidation()
             : base(typeof(DateTime), DateTime.Now.AddMinutes(-1).ToString(), DateTime.Now.AddYears(2).ToString()) { }
    }
}
