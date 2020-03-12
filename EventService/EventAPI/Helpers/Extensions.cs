using EventAPI.Models.Enums;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EventAPI.Helpers
{
    public static class Extensions
    {
        public static bool IsEventActive(this DateTime theDateTime)
        {
            if(theDateTime > DateTime.Now)
            {
                return true;
            }
            return false;
        }
        public static string EventStatusConvert(this int eventstatus)
        {
            var status = (Status)Enum.Parse(typeof(Status), eventstatus.ToString());

            return status.ToString();
        }
    }
}
