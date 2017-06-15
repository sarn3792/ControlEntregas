using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ControlEntregas.Code
{
    public class RegisterBindingModel
    {
        public string Email { get; set; }
        public string Password { get; set; }
        public string ConfirmPassword { get; set; }
        public int fkCliente { get; set; }
        public bool Enabled { get; set; }
        public string FullName { get; set; }
        public string Position { get; set; }

        public RegisterBindingModel()
        {

        }
    }
}