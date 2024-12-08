<%@ Page Title="" Language="C#" MasterPageFile="~/Pagina_Maestra/PaginaMaestra.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="EjemploHerenciaPaginasWeb.Default" %>

<asp:Content ID="ContentHead" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="ContentMain" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="../Estilos/Default.css" rel="stylesheet" />

    <div class="Default-container">
        <div class="welcome-container">
            <h1>Bienvenidos</h1>
            <p>Haz click en uno de los botones para continuar</p>
        </div>
        <div class="form-group">
            <asp:Button ID="btnAlumno" runat="server" Text="Registro de Alumno" OnClick="btnAlumno_Click" CssClass="custom-button" />
        </div>

        <div class="form-group">
            <asp:Button ID="btnArrendador" runat="server" Text="Registro del Arrendador" OnClick="btnArrendador_Click" CssClass="custom-button" />
        </div>

        <div class="form-group">
            <asp:Button ID="btnInicioSesion" runat="server" Text="Inicio de Sesión" OnClick="btnInicioSesion_Click" CssClass="custom-button" />
        </div>
    </div>

</asp:Content>
