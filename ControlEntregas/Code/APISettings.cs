using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ControlEntregas.Code
{
    public class APISettings
    {
        public static readonly String API_URL = System.Configuration.ConfigurationManager.AppSettings["API"];
    }
}