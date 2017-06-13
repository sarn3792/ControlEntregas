﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Users.aspx.cs" Inherits="ControlEntregas.Users" Async="true" %>

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

        .hiddenCol {
            display: none;
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
    </style>
    <title>Users</title>
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
                    <li style="margin-right: 10px;"><%--<a href="Logout.aspx">Cerrar sesión</a>--%></li>
                </ul>
            </div>
        </div>
        <div class="container">
            <div class="text-center">
                <h3 class="black">Usuarios</h3>
                <br />
            </div>
            <div class="row">
                <div class="col-sm-12">
                    <div class="row">
                        <div class="col-sm-9 text-center">
                            <asp:Label ID="lblMensaje" runat="server" Visible="false"></asp:Label>
                        </div>
                        <div class="col-sm-3 text-right">
                            <asp:ImageButton ID="btnOpen" runat="server" Text="Show Modal Popup"/>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-12">
                    <div style="overflow-x: auto; width: 100%">
                        <asp:GridView ID="gvUsuarios" runat="server" AutoGenerateColumns="false" CssClass="table table-hover table-striped" GridLines="None">
                            <Columns>
                                <asp:BoundField HeaderText="ID" DataField="idUser" ItemStyle-CssClass="hiddenCol" HeaderStyle-CssClass="hiddenCol" />
                                <asp:BoundField HeaderText="Nombre completo" DataField="fullName" />
                                <asp:BoundField HeaderText="Nombre empresa" DataField="enterprise" />
                                <asp:BoundField HeaderText="Posición" DataField="position" />
                                <asp:BoundField HeaderText="Email" DataField="email" />
                                <asp:TemplateField HeaderText="Activo">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkActivo" runat="server" AutoPostBack="true" OnCheckedChanged="chkActivo_CheckedChanged" Checked='<%# Eval("status") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </div>
            <br />
            <br />
            <!-- ModalPopupExtender -->
            <ajaxToolkit:ModalPopupExtender ID="mp1" runat="server" PopupControlID="Panel1" TargetControlID="btnOpen"
                CancelControlID="btnCancelar" BackgroundCssClass="modalBackground">
            </ajaxToolkit:ModalPopupExtender>
            <asp:Panel ID="Panel1" runat="server" CssClass="modalPopup" align="center" Style="display: none">
                <div style="height: 50%">
                    <div class="row">
                        <div class="col-sm-12">
                            <table class="table table-hover">
                                <tr>
                                    <td class="col-sm-4 text-right">
                                        <asp:Label ID="lblNombreCompleto" runat="server" Text="Nombre completo:"></asp:Label>
                                    </td>
                                    <td class="col-sm-8 text-left">
                                        <asp:TextBox ID="txtNombreCompleto" runat="server" CssClass="form-control"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvNombreCompleto" runat="server" ControlToValidate="txtNombreCompleto" ValidationGroup="GuardarUsuario" Text="Ingrese nombre completo" ForeColor="Red">
                                        </asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="col-sm-4 text-right">
                                        <asp:Label ID="lblPosicion" runat="server" Text="Posición:"></asp:Label>
                                    </td>
                                    <td class="col-sm-8 text-left">
                                        <asp:TextBox ID="txtPosicion" runat="server" CssClass="form-control"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvPosicion" runat="server" ControlToValidate="txtPosicion" ValidationGroup="GuardarUsuario" Text="Ingrese posición" ForeColor="Red">
                                        </asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="col-sm-4 text-right">
                                        <asp:Label ID="lblEmail" runat="server" Text="Email:"></asp:Label>
                                    </td>
                                    <td class="col-sm-8 text-left">
                                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" ValidationGroup="GuardarUsuario" Text="Ingrese email" ForeColor="Red">
                                        </asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail" ValidationExpression="^[\w!#$%&'*+\-/=?\^_`{|}~]+(\.[\w!#$%&'*+\-/=?\^_`{|}~]+)*@((([\-\w]+\.)+[a-zA-Z]{2,4})|(([0-9]{1,3}\.){3}[0-9]{1,3}))$" ErrorMessage="Sólo emails" ForeColor="Red" ValidationGroup="GuardarUsuario">
                                        </asp:RegularExpressionValidator>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
                <asp:Button ID="btnGuardarUsuario" runat="server" Text="Guardar" ValidationGroup="GuardarUsuario" OnClick="btnGuardarUsuario_Click" CssClass="btn btn-primary top-buffer" />
                <asp:Button ID="btnCancelar" Text="Cancelar" runat="server" CssClass="btn btn-primary top-buffer" />
            </asp:Panel>
        </div>
    </form>
</body>
</html>
