<%@ Page Title="Menú Arrendador" Language="C#" MasterPageFile="~/Pagina_Maestra/PaginaMaestra.Master" AutoEventWireup="true" CodeBehind="Menu_Arrendador_Principal.aspx.cs" Inherits="EjemploHerenciaPaginasWeb.MenuArrendador" %>

<asp:Content ID="ContentHead" ContentPlaceHolderID="head" runat="server">
    <link href="../Estilos/Menu_Arrendador.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="ContentMain" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Contenedor del correo -->
    <div id="correo-container" class="child-container">
        <asp:Label
            ID="lblCorreo"
            runat="server"
            Text="El correo aparecerá aquí"
            CssClass="label-correo"></asp:Label>
    </div>

    <!-- Contenedor de botones de acción -->
    <div id="action-buttons-container" class="child-container">
        <asp:Button
            ID="btnAgregarDepartamento"
            runat="server"
            Text="Agregar Departamento"
            OnClick="BtnAgregarDepartamento_Click"
            CssClass="custom-button" />
        
        <asp:Button
            ID="Comentarios"
            runat="server"
            Text="Ver Comentarios"
            OnClick="Comentarios_Click"
            CssClass="custom-button" />
    </div>

    <!-- Contenedor principal -->
    <div id="main-container" class="main-container">
        <!-- Contenedor central -->
        <div id="center-container" class="parent-container">
            <!-- Listado de departamentos -->
            <asp:Repeater ID="RepeaterDepartamentos" runat="server" OnItemCommand="RepeaterDepartamentos_ItemCommand">
                <ItemTemplate>
                    <div class="departamento-item child-container">
                        <!-- Imagen del departamento -->
                        <img
                            src='<%# Eval("FotoBase64") %>'
                            alt="Imagen del Departamento"
                            class="departamento-img" />

                        <!-- Información del departamento -->
                        <div class="departamento-info">
                            <h3><%# Eval("InformacionBreve") %></h3>
                            <p><strong>Precio:</strong> $<%# Eval("Precio") %></p>
                            <p>
                                <strong>Dirección:</strong> <%# Eval("Calle") %>, <%# Eval("Colonia") %>, <%# Eval("Ciudad") %>, <%# Eval("Municipio") %>
                            </p>
                            <p>
                                <strong>Recámaras:</strong> <%# Eval("NumeroRecamaras") %> |
                                <strong>Baños:</strong> <%# Eval("NumeroBanos") %>
                            </p>
                        </div>

                        <!-- Botón para eliminar -->
                        <asp:Button
                            ID="btnEliminar"
                            runat="server"
                            CommandName="Eliminar"
                            CommandArgument='<%# Eval("DepartamentoID") %>'
                            Text="Eliminar"
                            CssClass="custom-button" />
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>
</asp:Content>
