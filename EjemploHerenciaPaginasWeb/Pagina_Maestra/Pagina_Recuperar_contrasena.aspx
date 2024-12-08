<%@ Page Title="Recuperar Contraseña" Language="C#" MasterPageFile="~/Pagina_Maestra/PaginaMaestra.Master" AutoEventWireup="true" CodeBehind="Pagina_Recuperar_contrasena.aspx.cs" Inherits="EjemploHerenciaPaginasWeb.Pagina_Maestra.Pagina_Recuperar_contrasena" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../Estilos/Recuperar_Contrasena.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="recovery-container">
        <p class="recovery-message">
            Ingrese su correo con el que fue registrado. En caso de estar registrado, le llegará un correo con la contraseña.
        </p>
        <asp:TextBox ID="Correo_Recuperacion" runat="server" CssClass="input-field" Placeholder="Correo electrónico" />
        <br />
        <asp:Button ID="BtnEnviar" runat="server" Text="ENVIAR" OnClick="BtnEnviar_Click" CssClass="custom-button" />
    </div>
</asp:Content>
