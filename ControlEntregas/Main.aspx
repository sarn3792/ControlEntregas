<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Main.aspx.cs" Inherits="ControlEntregas.Main" %>

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

        .borderless td, .borderless th {
            border: none !important;
        }

        .menu div div {
            margin-bottom: 8% !important;
        }

            .menu div div a img:hover {
                background-color: gray;
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
    <title>Main</title>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="text-center">
                <h2 class="black">CONTROL DE ENTREGAS</h2>
                <br />
                <br />
            </div>
            <div class="row">
                <div class="col-sm-12">
                    <div class="menu">
                        <div class="row text-center">
                            <div class="col-sm-4">
                                <a href="Users.aspx">
                                    <asp:Image runat="server" ImageUrl="~/Images/team.png" />
                                </a>
                                <br />
                                Usuarios
                            </div>
                            <div class="col-sm-4">
                                <a href="Devices.aspx">
                                    <asp:Image runat="server" ImageUrl="~/Images/smartphone.png" />
                                </a>
                                <br />
                                Dispositivos
                            </div>
                            <div class="col-sm-4">
                                <a href="Tracker.aspx">
                                    <asp:Image runat="server" ImageUrl="~/Images/maps-and-flags.png" />
                                </a>
                                <br />
                                Tracker
                            </div>
                        </div>
                        <div class="row text-center">
                            <div class="col-sm-6">
                                <a href="PushDelivers.aspx">
                                    <asp:Image runat="server" ImageUrl="~/Images/ship.png" />
                                </a>
                                <br />
                                Push delivers
                            </div>
                            <div class="col-sm-6">
                                <a href="GetDelivers.aspx">
                                    <asp:Image runat="server" ImageUrl="~/Images/statistics.png" />
                                </a>
                                <br />
                                Get delivers
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <br />
            <!-- Popup -->
        </div>
    </form>
</body>
</html>
