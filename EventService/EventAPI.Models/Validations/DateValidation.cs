using System;
using System.ComponentModel.DataAnnotations;

namespace EventAPI.Models.Validations
{
    public class DateValidation : RangeAttribute
    {
        public DateValidation()
             : base(typeof(DateTime), DateTime.UtcNow.ToString(), DateTime.UtcNow.AddYears(2).ToString()) { }
    }
}
