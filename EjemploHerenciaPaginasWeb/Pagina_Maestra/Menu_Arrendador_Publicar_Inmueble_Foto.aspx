<%@ Page Title="Publicar Fotos" Language="C#" MasterPageFile="~/Pagina_Maestra/PaginaMaestra.Master" AutoEventWireup="true" CodeBehind="Menu_Arrendador_Publicar_Inmueble_Foto.aspx.cs" Inherits="EjemploHerenciaPaginasWeb.Pagina_Maestra.Menu_Arrendador_Publicar_Inmueble1" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="../Estilos/Menu_Arrendador_Publicar_Foto.css" rel="stylesheet" />
    <!-- Mostrar el correo del arrendador -->
    <p>
        Correo del arrendador:
        <asp:Label ID="lblCorreo" runat="server" CssClass="correo-label"></asp:Label>
    </p>

    <div class="upload-container">
        <h1>Agregar Departamento</h1>
        <h2>¡COMPARTE FOTOS DE TU INMUEBLE! </h2>
        <div class="form-group">
            <!-- Campo para agregar información breve -->
            <asp:Label ID="Mensaje" runat="server" Text="Puedes subir hasta 10 imágenes:" CssClass="form-label"></asp:Label>
        </div>

        <asp:FileUpload ID="fileUpload1" runat="server" AllowMultiple="true" CssClass="file-upload" />
       

      <%--  <div class="form-group">
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
        </div>--%>

        <div class="button-container">
            <asp:Button ID="btnSubir" runat="server" Text="Continuar" CssClass="custom-button" OnClick="btnSubir_Click" />
        </div>

        <asp:Label ID="lblDepartamentoID" runat="server" CssClass="departamento-label"></asp:Label>

        <asp:Label ID="lblMensaje" runat="server" CssClass="upload-message" Visible="false"></asp:Label>
    </div>
</asp:Content>
