<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="_01_HolaMundoWP_UI.index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="lblNombre" runat="server" Text="Escriba su nombre"></asp:Label>
            <asp:TextBox ID="txbNombre" runat="server"></asp:TextBox>
            <asp:Button ID="btnSaludar" OnClick="btnSaludar_Click" runat="server" Text="Saludar"/>
            <asp:Label ID="lblSaludar" runat="server" Text=""></asp:Label>
        </div>
    </form>
</body>
</html>
