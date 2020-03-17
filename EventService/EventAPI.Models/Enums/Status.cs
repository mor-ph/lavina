using System.Runtime.Serialization;

namespace EventAPI.Models.Enums
{
    public enum Status
    {
        [EnumMember(Value = "Upcoming")]
        Upcoming = 1,
        HappeningNow = 2,
        Finished = 3,
    }
}
