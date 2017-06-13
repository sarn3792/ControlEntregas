using ControlEntregas.Code;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Threading.Tasks;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ControlEntregas
{
    public partial class Users : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) //first time
            {
                this.LoadUsers().Wait();
            }
        }

        protected async void chkActivo_CheckedChanged(object sender, EventArgs e)
        {
            try
            {
                GridViewRow row = ((GridViewRow)((CheckBox)sender).NamingContainer);
                String idUser = row.Cells[0].Text;
                int index = row.RowIndex;
                CheckBox cb1 = (CheckBox)gvUsuarios.Rows[index].FindControl("chkActivo");
                await this.UploadStatus(cb1.Checked, idUser);
                this.MostarMensaje(false, "Registro actualizado correctamente");
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private async Task LoadUsers()
        {
            try
            {
                using (HttpClient client = new HttpClient())
                {
                    client.BaseAddress = new Uri(APISettings.API_URL);
                    client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                    HttpResponseMessage response = await client.GetAsync("api/Account/GetUsers?customer=2").ConfigureAwait(false);
                    if (response.IsSuccessStatusCode)
                    {
                        List<IDUser> clientes = response.Content.ReadAsAsync<IEnumerable<IDUser>>().Result.ToList();
                        gvUsuarios.DataSource = clientes;
                        gvUsuarios.DataBind();
                    }
                    else
                    {
                        throw new Exception("Ha ocurrido un error al consultar la API");
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private async Task UploadStatus(bool status, String idUser)
        {
            try
            {
                using (HttpClient client = new HttpClient())
                {
                    IDUser user = new IDUser();
                    user.status = status;
                    user.idUser = idUser;

                    client.BaseAddress = new Uri(APISettings.API_URL);
                    HttpResponseMessage response = await client.PutAsJsonAsync("api/Account/UpdateStatus", user).ConfigureAwait(false);
                    response.EnsureSuccessStatusCode();
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private void MostarMensaje(bool error, String mensaje)
        {
            if (!error)
            {
                lblMensaje.Text = mensaje;
                lblMensaje.CssClass = "successfully";
                lblMensaje.Visible = true;
            }
            else
            {
                lblMensaje.Text = "Ha ocurrido un error. Contacte al administrador";
                lblMensaje.CssClass = "error";
                lblMensaje.Visible = true;
            }
        }

        protected void btnGuardarUsuario_Click(object sender, EventArgs e)
        {
            //The fields are cleared so that next time that popup is shown does not display older values
        }
    }
}