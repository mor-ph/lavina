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
    }
}
