<%@ Page Title="Publicar Dirección" Language="C#" MasterPageFile="~/Pagina_Maestra/PaginaMaestra.Master" AutoEventWireup="true" CodeBehind="Menu_Arrendador_Publicar_Inmueble_Direccion.aspx.cs" Inherits="EjemploHerenciaPaginasWeb.Pagina_Maestra.Menu_Arrendador_Publicar_Inmueble_Direccion" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="../Estilos/Menu_Arrendador_Publicar_Inmueble_Direccion.css" rel="stylesheet" />

    
    <div class="login-container">
        <h1>Agregar Departamento</h1>
        <h2>DIRECCIÓN</h2>
        <%--<label for="txtFotoDepartamento" class="form-label">DIRECCIÓN: </label>--%>

        <div class="form-group">
            <label for="txtCalle" class="form-label">Calle: </label>
            <asp:TextBox ID="txtCalle" runat="server" placeholder="Calle" CssClass="input-field" MaxLength="50"></asp:TextBox>
            <asp:Label ID="lblErrorCalle" runat="server" CssClass="error-message" Visible="false"></asp:Label>
        </div>

        <div class="form-group">
            <label for="txtColonia" class="form-label">Colonia:</label>
            <asp:TextBox ID="txtColonia" runat="server" placeholder="Colonia" CssClass="input-field" MaxLength="50"></asp:TextBox>
            <asp:Label ID="lblErrorColonia" runat="server" CssClass="error-message" Visible="false"></asp:Label>
        </div>

        <div class="form-group">
            <label for="txtCiudad" class="form-label">Ciudad: </label>
            <asp:TextBox ID="txtCiudad" runat="server" placeholder="Ciudad" CssClass="input-field" MaxLength="20"></asp:TextBox>
            <asp:Label ID="lblErrorCiudad" runat="server" CssClass="error-message" Visible="false"></asp:Label>
        </div>

        <div class="form-group">
            <label for="txtMunicipio" class="form-label">Municipio:</label>
            <asp:TextBox ID="txtMunicipio" runat="server" placeholder="Municipio" CssClass="input-field" MaxLength="30"></asp:TextBox>
            <asp:Label ID="lblErrorMunicipio" runat="server" CssClass="error-message" Visible="false"></asp:Label>
        </div>

        <!-- Botón de Confirmar -->
        <div class="button-container">
            <asp:Button ID="btnConfirmarDireccion" runat="server" Text="Continuar" CssClass="custom-button" OnClick="BtnConfirmarDireccion_Click" />
            <asp:Label ID="lblDepartamentoID" runat="server" CssClass="info-label" Visible="false"></asp:Label>
        </div>
    </div>
</asp:Content>
