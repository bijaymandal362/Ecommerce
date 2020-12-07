using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebApplicationECommerceWebsite.Models.ViewModel
{
    public class LoginViewModel
    {
        public int UserId { get; set; }
        public String UserName { get; set; }

        public String Password { get; set; }
        public bool RememberMe { get; set; }
    }
}