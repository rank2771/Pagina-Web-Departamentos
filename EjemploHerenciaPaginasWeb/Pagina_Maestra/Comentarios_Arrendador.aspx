<%@ Page Title="Aprobación de comentarios" Language="C#" MasterPageFile="~/Pagina_Maestra/PaginaMaestra.Master" AutoEventWireup="true" 
    CodeBehind="Comentarios_Arrendador.aspx.cs" Inherits="EjemploHerenciaPaginasWeb.Pagina_Maestra.Comentarios_Arrendador" %>

<asp:Content ID="ContentHead" ContentPlaceHolderID="head" runat="server">
    <!-- Vincular la hoja de estilos -->
    <link href="Estilos/styles.css" rel="stylesheet" type="text/css" />
</asp:Content>

<asp:Content ID="ContentMain" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="../Estilos/Comentarios_Arrendador.css" rel="stylesheet" />
    <div class="contenedor-principal">
        <!-- Encabezado -->
        <h1 class="titulo-seccion">Aprobación de Comentarios</h1>

        <!-- Mensajes de error o información -->
        <asp:Label ID="lblMensaje" runat="server" CssClass="mensaje-error" Visible="false"></asp:Label>

        <!-- Tabla de comentarios -->
        <div class="contenedor-comentarios">
            <asp:GridView ID="gridComentarios" runat="server" AutoGenerateColumns="false" CssClass="tabla-comentarios" OnRowCommand="gridComentarios_RowCommand">
                <Columns>
                    <asp:BoundField DataField="ID" HeaderText="ID" />
                    <asp:BoundField DataField="Usuario" HeaderText="Usuario" />
                    <asp:BoundField DataField="Fecha" HeaderText="Fecha" DataFormatString="{0:yyyy-MM-dd HH:mm}" />
                    <asp:BoundField DataField="VerificacionID" HeaderText="Verificación" />
                    <asp:TemplateField HeaderText="Acciones">
                        <ItemTemplate>
                            <!-- Botón para aprobar -->
                            <asp:Button ID="btnAprobar" runat="server" Text="Aprobar" CommandName="Aprobar" CommandArgument='<%# Eval("ID") %>' CssClass="btn-aprobar" />
                            <!-- Botón para rechazar -->
                            <asp:Button ID="btnRechazar" runat="server" Text="Rechazar" CommandName="Rechazar" CommandArgument='<%# Eval("ID") %>' CssClass="btn-rechazar" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </div>
</asp:Content>
