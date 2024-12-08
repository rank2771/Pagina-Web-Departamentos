<%@ Page Title="Menú Usuario" Language="C#" MasterPageFile="~/Pagina_Maestra/PaginaMaestra.Master" AutoEventWireup="true" CodeBehind="Pagina_Menu_usuario.aspx.cs" Inherits="EjemploHerenciaPaginasWeb.Pagina_Maestra.WebForm1" %>

<asp:Content ID="ContentHead" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="ContentMain" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Enlace al archivo CSS -->
    <link href="../Estilos/Menu_Usuario.css" rel="stylesheet" />
    <!-- Repeater para mostrar los departamentos -->
    <asp:Repeater ID="RepeaterDepartamentos" runat="server" OnItemCommand="RepeaterDepartamentos_ItemCommand">
        <ItemTemplate>
            <div class="departamento-container">
                <!-- Imagen del departamento con enlace -->
                <div class="departamento-imagen">
                    <asp:ImageButton 
                        ID="imgDepartamento" 
                        runat="server" 
                        ImageUrl='<%# Eval("FotoBase64") %>' 
                        CommandName="VerDetalles" 
                        CommandArgument='<%# Eval("DepartamentoID") %>' 
                        CssClass="departamento-imagen" />
                </div>
                
                <!-- Información del departamento -->
                <div class="departamento-info">
                    <p>
                        <strong>Precio:</strong> <%# Eval("Precio", "{0:C}") %>
                    </p>
                    <p>
                        <strong>Breve Descripción:</strong> <%# Eval("InformacionBreve") %>
                    </p>
                </div>
            </div>
        </ItemTemplate>
    </asp:Repeater>
</asp:Content>
