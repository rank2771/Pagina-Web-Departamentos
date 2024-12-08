<%@ Page Title="" Language="C#" MasterPageFile="~/Pagina_Maestra/Menu Arrendador.master" AutoEventWireup="true" CodeBehind="Menu_Arrendador_Publicar_Inmueble.aspx.cs" Inherits="EjemploHerenciaPaginasWeb.Pagina_Maestra.Menu_Arrendador_Publicar_Inmueble" %>
<asp:Content ID="ContentHead" ContentPlaceHolderID="head" runat="server">
    <!-- Puedes agregar estilos específicos para esta página aquí -->
</asp:Content>

<asp:Content ID="ContentMain" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Contenedor del logo -->
    <div class="logo-container">
        <div class="logo">
            LOGO
        </div>
    </div>

    <!-- Título de la sección -->
    <h2 class="titulo-seccion">¡COMPARTE FOTOS DE TU INMUEBLE!</h2>

    <!-- Botón para agregar imágenes -->
    <div class="agregar-fotos-container">
        <button class="boton-agregar">AGREGAR</button>
    </div>

    <!-- Botón de Continuar -->
    <div class="boton-continuar-container">
        <button class="boton-continuar">CONTINUAR</button>
    </div>
</asp:Content>