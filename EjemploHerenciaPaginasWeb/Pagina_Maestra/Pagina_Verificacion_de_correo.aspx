     <%@ Page Title="Verificación Correo" Language="C#" MasterPageFile="~/Pagina_Maestra/PaginaMaestra.Master" AutoEventWireup="true" CodeBehind="Pagina_Verificacion_de_correo.aspx.cs" Inherits="EjemploHerenciaPaginasWeb.Verificacion" %>

<%--En esta parte tenemos la entrada de codigo para realizar la verificacion del mismo.--%>

<asp:Content ID="ContentMain" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Importación del CSS -->


    <!-- Contenedor Principal -->
    <div class="verificacion-container">
        <!-- Mensajes de Instrucción -->
        <p>Hemos enviado un código de verificación a "ejemplo@alumno.ipn.mx"</p>
        <p>Por favor introduce el código de 6 dígitos a continuación:</p>
        <link href="../Estilos/Verificacion_Correo.css" rel="stylesheet" />
        <!-- Contenedor de los Inputs del Código -->
        <div class="codigo-container">
            <input id="CodigoInput1" runat="server" type="text" maxlength="1" class="codigo-input" />
            <input id="CodigoInput2" runat="server" type="text" maxlength="1" class="codigo-input" />
            <input id="CodigoInput3" runat="server" type="text" maxlength="1" class="codigo-input" />
            <input id="CodigoInput4" runat="server" type="text" maxlength="1" class="codigo-input" />
            <input id="CodigoInput5" runat="server" type="text" maxlength="1" class="codigo-input" />
            <input id="CodigoInput6" runat="server" type="text" maxlength="1" class="codigo-input" />
        </div>

        <!-- Mensaje de Error (Oculto por defecto) -->
        <asp:Label ID="ErrorMessage" runat="server" CssClass="error-message" Visible="false"></asp:Label>

        <!-- Contenedor de Botones -->
        <div class="botones-container">
            <asp:Button ID="Validar" runat="server" CssClass="custom-button" OnClick="Validar_Click" Text="Confirmar" />
        </div>
    </div>
</asp:Content>