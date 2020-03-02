using Microsoft.IdentityModel.Tokens;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CommentService.Data
{
    public class AuthOptions
    {
        const string SECRET_KEY = "MaYzkSjmkzPC57Lfghdfhgdhdfhdghfgghgjhggjgfjfgjd";   // key for encoding
        public const int LIFETIME = 1200000; // token lifetime
        public static SymmetricSecurityKey GetSymmetricSecurityKey()
        {
            return new SymmetricSecurityKey(Encoding.ASCII.GetBytes(SECRET_KEY));
        }
    }
}
