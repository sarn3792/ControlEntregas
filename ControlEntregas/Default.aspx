<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="ControlEntregas.Default" Async="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <script src="Scripts/jquery-1.9.1.min.js"></script>
    <link href="Content\bootstrap.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        body {
            padding-top: 70px;
        }

        .error {
            color: red;
            font-weight: bold;
        }

        .successfully {
            color: forestgreen;
            font-weight: bold;
        }

        .black {
            font-weight: bold;
        }

        .modalBackground {
            background-color: gray;
            filter: alpha(opacity=90);
            opacity: 0.8;
        }

        .modalPopup {
            background-color: #fff;
            border: 3px solid #ccc;
            border-radius: 6px;
            padding: 10px;
            width: 50%;
        }

        .btnSmall {
            height: 30px !important;
            padding: 0px 5px 0px 5px !important;
            /*background-color: #67b346;*/
        }
    </style>
    <title>Default</title>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager runat="server"></asp:ScriptManager>
        <div class="navbar navbar-inverse navbar-fixed-top">
            <div class="container">
                <ul class="nav navbar-nav">
                    <%--<li><a href="Default.aspx">Inicio</a></li>
                    <li class="active"><a href="Calificar.aspx">Verificación información</a></li>
                    <li><a href="Inusuales.aspx">Inusuales/24 horas</a></li>
                    <li><a href="InternasPreocupantes.aspx">Internas Preocupantes</a></li>
                    <li><a href="Criterios.aspx">Criterios</a></li>--%>
                </ul>
                <ul class="nav navbar-nav navbar-right">
                    <li style="margin-right: 10px;"><a href="Logout.aspx">Cerrar sesión</a></li>
                </ul>
            </div>
        </div>
        <div class="container">
            <div class="text-center">
                <h3 class="black">Clientes</h3>
                <br />
            </div>
            <div class="row">
                <div class="col-sm-12">
                    <div class="row">
                        <div class="col-sm-11 text-center">
                            <div style="margin-left: 8.33%">
                                <asp:Label ID="lblMensaje" runat="server" Visible="false"></asp:Label>
                            </div>
                        </div>
                        <div class="col-sm-1 text-right">
                            <%--<asp:Button ID="btnAgregar" runat="server" CssClass="btnAdd"/>--%>
                            <asp:Button ID="btnAgregar" runat="server" CssClass="btn btn-primary top-buffer btnSmall" Text="Agregar" />
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-12">
                    <div style="overflow-x: auto; width: 100%; margin-top: 5px;">
                        <asp:GridView ID="gvClientes" runat="server" AutoGenerateColumns="false" CssClass="table table-hover table-striped" GridLines="None">
                            <Columns>
                                <asp:BoundField HeaderText="ID" DataField="IDCliente" />
                                <asp:BoundField HeaderText="Nombre empresa" DataField="NombreEmpresa" />
                                <asp:BoundField HeaderText="Contacto sistemas" DataField="ContactoSistemas" />
                                <asp:BoundField HeaderText="Teléfono" DataField="Telefono" />
                                <asp:BoundField HeaderText="Email" DataField="Email" />
                                <asp:BoundField HeaderText="Grupo" DataField="Grupo" />
                                <asp:TemplateField HeaderText="Activo">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkActivo" runat="server" AutoPostBack="true" OnCheckedChanged="chkSelect_CheckedChanged" Checked='<%# Eval("Activo") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:Button ID="btnAbrirSitio" runat="server" OnClick="btnAbrirSitio_Click" Text="Abrir sitio" CssClass="btn btn-primary top-buffer" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </div>
            <br />
            <!-- PopUp -->
            <ajaxToolkit:ModalPopupExtender ID="mp1" runat="server" PopupControlID="pnlPopUp" TargetControlID="btnAgregar"
                CancelControlID="btnCancelar" BackgroundCssClass="modalBackground">
            </ajaxToolkit:ModalPopupExtender>
            <asp:Panel ID="pnlPopUp" runat="server" CssClass="modalPopup" align="center" Style="display: none">
                <div class="row">
                    <div class="col-sm-12">
                        <table class="table table-hover">
                            <tr>
                                <td class="col-sm-4 text-right">
                                    <asp:Label ID="lblNombreEmpresa" runat="server" Text="Nombre empresa:"></asp:Label>
                                </td>
                                <td class="col-sm-8 text-left">
                                    <asp:TextBox ID="txtNombreEmpresa" runat="server" CssClass="form-control"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvNombreEmpresa" runat="server" ControlToValidate="txtNombreEmpresa" ValidationGroup="Guardar" Text="Ingrese nombre empresa" ForeColor="Red">
                                    </asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td class="col-sm-4 text-right">
                                    <asp:Label ID="lblContactoSistemas" runat="server" Text="Contacto sistemas:"></asp:Label>
                                </td>
                                <td class="col-sm-8 text-left">
                                    <asp:TextBox ID="txtContactoSistemas" runat="server" CssClass="form-control"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvContactoSistemas" runat="server" ControlToValidate="txtContactoSistemas" ValidationGroup="Guardar" Text="Ingrese contacto sistemas" ForeColor="Red">
                                    </asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td class="col-sm-4 text-right">
                                    <asp:Label ID="lblTelefono" runat="server" Text="Teléfono:"></asp:Label>
                                </td>
                                <td class="col-sm-8 text-left">
                                    <asp:TextBox ID="txtTelefono" runat="server" CssClass="form-control"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvTelefono" runat="server" ControlToValidate="txtTelefono" ValidationGroup="Guardar" Text="Ingrese teléfono" ForeColor="Red">
                                    </asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="revTelefono" runat="server" ControlToValidate="txtTelefono" ValidationExpression="^-*[0-9,-\.]+$" ErrorMessage="Sólo números" ForeColor="Red" ValidationGroup="Guardar">
                                    </asp:RegularExpressionValidator>
                                </td>
                            </tr>
                            <tr>
                                <td class="col-sm-4 text-right">
                                    <asp:Label ID="lblEmail" runat="server" Text="Email:"></asp:Label>
                                </td>
                                <td class="col-sm-8 text-left">
                                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" ValidationGroup="Guardar" Text="Ingrese email" ForeColor="Red">
                                    </asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail" ValidationExpression="^[\w!#$%&'*+\-/=?\^_`{|}~]+(\.[\w!#$%&'*+\-/=?\^_`{|}~]+)*@((([\-\w]+\.)+[a-zA-Z]{2,4})|(([0-9]{1,3}\.){3}[0-9]{1,3}))$" ErrorMessage="Sólo emails" ForeColor="Red" ValidationGroup="Guardar">
                                    </asp:RegularExpressionValidator>
                                </td>
                            </tr>
                            <tr>
                                <td class="col-sm-4 text-right">
                                    <asp:Label ID="lblGrupo" runat="server" Text="Grupo:"></asp:Label>
                                </td>
                                <td class="col-sm-8 text-left">
                                    <asp:TextBox ID="txtGrupo" runat="server" CssClass="form-control"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvGrupo" runat="server" ControlToValidate="txtGrupo" ValidationGroup="Guardar" Text="Ingrese grupo" ForeColor="Red">
                                    </asp:RequiredFieldValidator>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="text-center">
                        <asp:Button ID="btnGuardar" ValidationGroup="Guardar" CssClass="btn btn-primary top-buffer" Text="Guardar" runat="server" OnClick="btnGuardar_Click" />
                        <asp:Button ID="btnCancelar" Text="Cancelar" runat="server" CssClass="btn btn-primary top-buffer" />
                    </div>
                </div>
            </asp:Panel>
        </div>
    </form>
</body>
</html>
