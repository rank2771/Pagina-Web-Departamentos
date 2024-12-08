<%@ Page Title="Inicio de Sesión" Language="C#" MasterPageFile="~/Pagina_Maestra/PaginaMaestra.Master" 
    AutoEventWireup="true" CodeBehind="Inicio_Sesion.aspx.cs" 
    Inherits="EjemploHerenciaPaginasWeb.login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="ContentMain" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="../Estilos/Inicio_Sesion.css" rel="stylesheet" />
    <div class="login-container">
        <h1 class="login-title">Iniciar Sesión</h1>

        <div class="form-group">
            <label for="Correo" class="form-label">Correo:</label>
            <asp:TextBox ID="Correo_1" runat="server" CssClass="input-field" TextMode="Email" Placeholder="Introduce tu correo" maxlength="50" />
        </div>

        <div class="form-group">
            <label for="Contrasena" class="form-label">Contraseña:</label>
            <asp:TextBox ID="Contrasena_1" runat="server" CssClass="input-field" TextMode="Password" Placeholder="Introduce tu contraseña" maxlength="16" />
        </div>

        <div class="forgot-password">
            <a href="Pagina_Recuperar_contrasena.aspx" class="forgot-link">¿Olvidaste tu contraseña?</a>
        </div>

        <div class="button-container">
            <asp:Button ID="BtnLogin" runat="server" Text="Iniciar Sesión" OnClick="BTNLogin_Click" CssClass="custom-button" />
        </div>
    </div>
</asp:Content>
