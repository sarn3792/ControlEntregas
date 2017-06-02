using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ControlEntregas.Code;
using System.Threading.Tasks;

namespace ControlEntregas
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["user"] == null)
            {
                Response.Redirect("Login.aspx");
            }

            if (!IsPostBack) //first time
            {
                this.LoadClientes();
            }
        }

        protected async void btnGuardar_Click(object sender, EventArgs e)
        {
            try
            {
                await this.SaveClientes();
                this.LoadClientes();
                this.LimpiarCampos();
                this.MostarMensaje(false);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private void LoadClientes()
        {
            try
            {
                using (HttpClient client = new HttpClient())
                {
                    client.BaseAddress = new Uri(APISettings.API_URL);
                    client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                    HttpResponseMessage response = client.GetAsync("api/Clientes").Result;
                    if (response.IsSuccessStatusCode)
                    {
                        List<Cliente> clientes = response.Content.ReadAsAsync<IEnumerable<Cliente>>().Result.ToList();
                        gvClientes.DataSource = clientes;
                        gvClientes.DataBind();
                    }
                    else
                    {
                        throw new Exception("Ha ocurrido un error al consultar la API");
                    }
                }

            } catch (Exception ex)
            {
                throw ex;
            }
        }

        private async Task SaveClientes()
        {
            try
            {
                using (HttpClient client = new HttpClient())
                {
                    Cliente cliente = new Cliente();
                    cliente.activo = true;
                    cliente.contactoSistemas = txtContactoSistemas.Text.Trim();
                    cliente.email = txtEmail.Text.Trim();
                    cliente.grupo = txtGrupo.Text.Trim();
                    cliente.nombreEmpresa = txtNombreEmpresa.Text.Trim();
                    cliente.telefono = txtTelefono.Text.Trim();

                    client.BaseAddress = new Uri(APISettings.API_URL);
                    HttpResponseMessage response = await client.PostAsJsonAsync("api/Clientes", cliente);
                    response.EnsureSuccessStatusCode();
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private async Task UpdateStatus(bool chkStatus, String id)
        {
            try
            {
                using (HttpClient client = new HttpClient())
                {
                    Cliente cliente = new Cliente();
                    cliente.activo = chkStatus;
                    cliente.idCliente = Convert.ToInt32(id);

                    client.BaseAddress = new Uri(APISettings.API_URL);
                    HttpResponseMessage response = await client.PutAsJsonAsync("api/Clientes/Estatus", cliente);
                    response.EnsureSuccessStatusCode();
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private void MostarMensaje(bool error)
        {
            if (!error)
            {
                lblMensaje.Text = "Información guardada correctamente";
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

        private void LimpiarCampos()
        {
            txtNombreEmpresa.Text = String.Empty;
            txtContactoSistemas.Text = String.Empty;
            txtTelefono.Text = String.Empty;
            txtEmail.Text = String.Empty;
            txtGrupo.Text = String.Empty;
        }

        protected async void chkSelect_CheckedChanged(object sender, EventArgs e)
        {
            try
            {
                GridViewRow row = ((GridViewRow)((CheckBox)sender).NamingContainer);
                String id = row.Cells[0].Text;
                int index = row.RowIndex;
                CheckBox cb1 = (CheckBox)gvClientes.Rows[index].FindControl("chkActivo");
                await this.UpdateStatus(cb1.Checked, id);
                MostarMensaje(false, "Registro actualizado correctamente");
            } 
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}