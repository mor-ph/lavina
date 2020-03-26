using EventAPI.Models.Enums;
using System;

namespace EventAPI.Models.Helpers
{
    public static class Extensions
    {
        public static string EventStatusConvert(this int eventstatus)
        {
            var status = (Status)Enum.Parse(typeof(Status), eventstatus.ToString());

            return status.ToString();
        }
        public static string TimeAgo(this DateTime yourDate)
        {
            const int SECOND = 1;
            const int MINUTE = 60 * SECOND;
            const int HOUR = 60 * MINUTE;
            const int DAY = 24 * HOUR;
            const int MONTH = 30 * DAY;

            var ts = new TimeSpan(DateTime.Now.Ticks - yourDate.Ticks);
            double delta = Math.Abs(ts.TotalSeconds);

            if (delta < 1 * MINUTE)
                return ts.Seconds == 1 ? "1 second ago" : ts.Seconds + " seconds ago";

            if (delta < 2 * MINUTE)
                return "1 minute ago";

            if (delta < 60 * MINUTE)
                return ts.Minutes + " minutes ago";

            if (delta < 120 * MINUTE)
                return "1 hour ago";

            if (delta < 24 * HOUR)
                return ts.Hours + " hours ago";

            if (delta < 48 * HOUR)
                return "1 day ago ";

            if (delta < 30 * DAY)
                return ts.Days + " days ago";

            if (delta < 12 * MONTH)
            {
                int months = Convert.ToInt32(Math.Floor((double)ts.Days / 30));
                return months <= 1 ? "1 month ago" : months + " months ago";
            }
            else
            {
                int years = Convert.ToInt32(Math.Floor((double)ts.Days / 365));
                return years <= 1 ? "1 year ago" : years + " years ago";
            }
        }
    }
}
