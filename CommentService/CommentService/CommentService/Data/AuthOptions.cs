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
        const string KEY = "cAtwa1kkEy";   // key for encoding
        public const int LIFETIME = 999; // token lifetime
        public static SymmetricSecurityKey GetSymmetricSecurityKey()
        {
            return new SymmetricSecurityKey(Encoding.ASCII.GetBytes(KEY));
        }
    }
}
