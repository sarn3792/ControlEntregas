using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ControlEntregas.Code
{
    public class Login
    {
        public String user;
        public String password;

        public Login(String user, String password)
        {
            this.user = user;
            this.password = password;
        }
    }
}