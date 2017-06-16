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
            if (Session["user"] == null)
            {
                Response.Redirect("Login.aspx");
            }

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
                    //Get users based on CustomerID
                    HttpResponseMessage response = await client.GetAsync(String.Format("api/Account/GetUsers?customer={0}", Convert.ToInt32(Session["CustomerID"].ToString()))).ConfigureAwait(false); //modify to get real customer ID
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

        private async Task SaveCustomer()
        {
            try
            {
                using (HttpClient client = new HttpClient())
                {
                    RegisterBindingModel data = new RegisterBindingModel();
                    data.FullName = txtNombreCompleto.Text.Trim();
                    data.Position = txtPosicion.Text.Trim();
                    data.Email = txtEmail.Text.Trim();
                    data.Enabled = true;
                    data.fkCliente = Convert.ToInt32(Session["CustomerID"].ToString()); //Session Atribute must be here
                    data.Password = txtContrasena.Text;
                    data.ConfirmPassword = txtConfirmarContrasena.Text;

                    client.BaseAddress = new Uri(APISettings.API_URL);
                    HttpResponseMessage response = await client.PostAsJsonAsync("api/Account/Register", data).ConfigureAwait(false);
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

        protected async void btnGuardarUsuario_Click(object sender, EventArgs e)
        {
            try
            {
                await this.SaveCustomer();
                await this.LoadUsers();
                this.LimpiarCampos();
                this.MostarMensaje(false, "Usuario guardado exitosamente");
            }
            catch (Exception ex)
            {
                throw ex;
            }
            
        }

        private void LimpiarCampos() //The fields are cleared so that next time that popup is shown does not display older values
        { 
            try
            {
                txtNombreCompleto.Text = String.Empty;
                txtPosicion.Text = String.Empty;
                txtEmail.Text = String.Empty;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        protected void btnEliminarUsuario_Click(object sender, EventArgs e)
        {
            try
            {
                GridViewRow row = ((GridViewRow)((Button)sender).NamingContainer);
                String id = row.Cells[0].Text;
                Session["userIdToEliminate"] = id; //The variable is used on Eliminar event
                lblNombreUsuario.Text = String.Format("¿Estás seguro de eliminar a <strong>{0}</strong>?", row.Cells[1].Text);
                mpYesNo.Show();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        protected async void btnEliminar_Click(object sender, EventArgs e)
        {
            try
            {
                await this.EliminarUsuario();
                MostarMensaje(false, "Usuario eliminado correctamente");
                await this.LoadUsers();
            } catch(Exception ex)
            {
                throw ex;
            }
        }

        private async Task EliminarUsuario()
        {
            try
            {
                using (HttpClient client = new HttpClient())
                {
                    client.BaseAddress = new Uri(APISettings.API_URL);
                    HttpResponseMessage response = await client.DeleteAsync(String.Format("api/Account/Delete/{0}", Session["userIdToEliminate"].ToString()));
                    response.EnsureSuccessStatusCode();
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}