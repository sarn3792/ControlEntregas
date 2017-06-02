using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ControlEntregas.Code;

namespace ControlEntregas
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            try
            {
                LoginController controller = new LoginController();
                if(controller.ValidateLogin(new Code.Login(txtUser.Text.Trim(), txtPassword.Text.Trim()))) //successfully
                {
                    Session["user"] = txtUser.Text.Trim();
                    lblError.Visible = false;
                    Response.Redirect("Default.aspx");
                }
                else
                {
                    lblError.Visible = true;
                }
            } catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}