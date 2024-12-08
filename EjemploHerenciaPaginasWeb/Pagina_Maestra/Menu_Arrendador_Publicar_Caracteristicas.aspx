<%@ Page Title="Publicar Caracteristicas" Language="C#" MasterPageFile="~/Pagina_Maestra/PaginaMaestra.Master" AutoEventWireup="true" CodeBehind="Menu_Arrendador_Publicar_Caracteristicas.aspx.cs" Inherits="EjemploHerenciaPaginasWeb.Pagina_Maestra.Menu_Arrendador_Publicar_Caracteristicas" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="../Estilos/Menu_Arrendador_Publicar_Caracteristicas.css" rel="stylesheet" />


    <div class="login-container">
        <h1>Agregar Departamento</h1>
        <h2>CARACTERÍSTICAS. </h2>

        <div class="form-group">
            <!-- Campo para agregar información breve -->
            <asp:Label ID="InformacionBreve" runat="server" Text="Información Departamento:" CssClass="form-label"></asp:Label>
            <asp:TextBox ID="txtInformacionBreve" runat="server" Placeholder="Información breve del departamento" CssClass="input-field"></asp:TextBox>
            <br />
        </div>

        <div class="form-group">
            <!-- Campo para agregar el precio -->
            <asp:Label ID="Precio" runat="server" Text="Precio:" CssClass="form-label"></asp:Label>
            <asp:TextBox ID="txtPrecio" runat="server" Placeholder="Precio del departamento" CssClass="input-field"></asp:TextBox>
            <br />
        </div>

        <%--Número de recamaras--%>
        <div class="form-group">
            <label for="Correo" class="form-label">Número de Recámaras: </label>
            <asp:TextBox ID="txtNumeroRecamaras" runat="server" placeholder="Número de Recámaras" CssClass="input-field" MaxLength="50"></asp:TextBox>
            <asp:Label ID="lblErrorRecamaras" runat="server" CssClass="error-message" Visible="false"></asp:Label>
        </div>

        <%--Número de baños--%>
        <div class="form-group">
            <label for="txtNumeroBanos" class="form-label">Número de Baños: </label>
            <asp:TextBox ID="txtNumeroBanos" runat="server" placeholder="Número de Baños" CssClass="input-field" MaxLength="50"></asp:TextBox>
            <asp:Label ID="lblErrorBanos" runat="server" CssClass="error-message" Visible="false"></asp:Label>
        </div>

        <%--Estacionamiento--%>
        <div class="form-group">
            <label for="txtEstacionamiento" class="form-label">Estacionamiento (1=Sí, 0=No):</label>
            <asp:TextBox ID="txtEstacionamiento" runat="server" placeholder="1 o 0" CssClass="input-field" MaxLength="1"></asp:TextBox>
            <asp:Label ID="lblErrorEstacionamiento" runat="server" CssClass="error-message" Visible="false"></asp:Label>
        </div>

        <%--Mascotas --%>
        <div class="form-group">
            <label for="txtMascotas" class="form-label">Mascotas (1=Sí, 0=No):</label>
            <asp:TextBox ID="txtMascotas" runat="server" placeholder="1 o 0" CssClass="input-field" MaxLength="1"></asp:TextBox>
            <asp:Label ID="lblErrorMascotas" runat="server" CssClass="error-message" Visible="false"></asp:Label>
        </div>

        <%--Amueblado--%>
        <div class="form-group">
            <label for="txtAmueblado" class="form-label">Amueblado (1=Sí, 0=No):</label>
            <asp:TextBox ID="txtAmueblado" runat="server" placeholder="1 o 0" CssClass="input-field" MaxLength="1"></asp:TextBox>
            <asp:Label ID="lblErrorAmueblado" runat="server" CssClass="error-message" Visible="false"></asp:Label>
        </div>

        <%--Botón Confirmar Características--%>
        <div class="button-container">
            <asp:Button ID="btnConfirmarCaracteristicas" runat="server" Text="Continuar" CssClass="custom-button" OnClick="BtnConfirmarCaracteristicas_Click" />
        </div>

    </div>

</asp:Content>
