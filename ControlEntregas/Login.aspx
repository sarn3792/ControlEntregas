<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="ControlEntregas.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <script src="Scripts/jquery-1.9.1.min.js"></script>
    <link href="Content\bootstrap.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .error {
            color: red;
            font-weight: bold;
        }
    </style>
    <title>Login</title>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager runat="server"></asp:ScriptManager>
        <asp:UpdateProgress ID="UpdPro" runat="server" AssociatedUpdatePanelID="UpdatePanel1">
                    <ProgressTemplate>
                        <div style="position: fixed; text-align: center; height: 100%; width: 100%; top: 0; right: 0; left: 0; z-index: 9999999; opacity: 1.7;">
                            <table class="auto-style2">
                                <tr>
                                    <td class="auto-style4">&nbsp;</td>
                                    <td class="auto-style6"></td>
                                    <td>&nbsp;</td>
                                </tr>
                            </table>
                            <asp:Image ID="imgProceso" runat="server" ImageUrl="~/Images/Progreso.gif" Style="height: 146px; width: 168px;" />
                        </div>
                    </ProgressTemplate>
                </asp:UpdateProgress>
        <div class="container">
            <div class="row">
                <div class="col-sm-12">
                    <div class="text-center">
                        <img src="Images/UN.jpg" style="width: 25%; height: 5%" />
                    </div>
                </div>
            </div>
            <br />
            <br />
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="text-center">
                                <h3>Control de entregas</h3>
                                <br />
                                <div style="margin-bottom: 10px;">
                                    <asp:Label ID="lblError" runat="server" Visible="false" CssClass="error">Usuario y/o contraseña incorrectos</asp:Label>
                                </div>
                                <asp:TextBox ID="txtUser" Width="25%" Style="margin: 0 auto; text-align: center;" runat="server" CssClass="form-control" placeholder="Usuario"></asp:TextBox>
                                <div style="margin-bottom: 8px;">
                                    <asp:RequiredFieldValidator ID="rfvUser" runat="server" ControlToValidate="txtUser" ErrorMessage="Ingresar usuario" ForeColor="Red"></asp:RequiredFieldValidator>
                                </div>
                                <asp:TextBox ID="txtPassword" Width="25%" Style="margin: 0 auto; text-align: center;" runat="server" CssClass="form-control" placeholder="Contraseña" TextMode="Password"></asp:TextBox>
                                <div style="margin-bottom: 8px;">
                                    <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPassword" ErrorMessage="Ingresar contraseña" ForeColor="Red"></asp:RequiredFieldValidator>
                                </div>
                                <asp:Button ID="btnLogin" runat="server" Text="Iniciar sesión" CssClass="btn btn-primary top-buffer" OnClick="btnLogin_Click" />
                            </div>
                        </div>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </form>
</body>
</html>
