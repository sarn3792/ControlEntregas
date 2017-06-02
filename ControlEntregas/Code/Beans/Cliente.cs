using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ControlEntregas.Code
{
    public class Cliente
    {
        public int idCliente { get; set; }
        public String nombreEmpresa { get; set; }
        public String contactoSistemas { get; set; }
        public String telefono { get; set; }
        public String email { get; set; }
        public String grupo { get; set; }
        public bool activo { get; set; }

        public Cliente()
        {

        }
    }
}