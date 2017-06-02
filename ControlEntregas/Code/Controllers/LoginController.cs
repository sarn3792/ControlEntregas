using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ControlEntregas.Code
{
    public class LoginController
    {
        public bool ValidateLogin(Login info)
        {
            try
            {
                LoginModel model = new LoginModel();
                return model.ValidateLogin(info);
            } catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}