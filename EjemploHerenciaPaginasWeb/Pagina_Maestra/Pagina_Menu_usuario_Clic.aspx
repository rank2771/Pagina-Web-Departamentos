<%@ Page Title="Información Inmueble" Language="C#" MasterPageFile="~/Pagina_Maestra/PaginaMaestra.Master" AutoEventWireup="true" CodeBehind="Pagina_Menu_usuario_Clic.aspx.cs" Inherits="EjemploHerenciaPaginasWeb.Pagina_Maestra.Pagina_Menu_usuario_Clic" %>

<asp:Content ID="ContentHead" ContentPlaceHolderID="head" runat="server">
    <!-- Agregar aquí estilos específicos para la página -->
</asp:Content>

<asp:Content ID="ContentMain" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="../Estilos/Menu_User_Clic.css" rel="stylesheet" />
    <!-- Contenedor Principal -->
    <div class="contenedor-principal">
        <!-- Columna Izquierda -->
        <div class="columna-izquierda">
            <!-- Sección de Imágenes -->
            <h2 class="titulo-seccion">Imágenes del Departamento</h2>
            <div class="slider">
                <asp:Repeater ID="RepeaterImagenes" runat="server">
                    <ItemTemplate>
                        <img src='<%# Eval("ImagenBase64") %>' alt="Imagen del Departamento" class="slider-imagen" />
                    </ItemTemplate>
                </asp:Repeater>
                <div class="botones-navegacion">
                    <button type="button" class="btn-navegacion" onclick="moverAnterior()">←</button>
                    <button type="button" class="btn-navegacion" onclick="moverSiguiente()">→</button>
                </div>
            </div>

            <!-- Sección de Comentarios -->
            <div class="seccion-comentarios">
                <h3 class="titulo-subseccion">Comentarios</h3>
                <asp:Button ID="btnEnviarComentario" CssClass="btn-enviar-comentario" Text="Enviar" runat="server" OnClick="btnEnviarComentario_Click" />
                <asp:TextBox ID="txtComentario" runat="server" CssClass="input-comentario" placeholder="Escribe un comentario "></asp:TextBox>
                <div class="lista-comentarios">
                    <asp:Repeater ID="RepeaterComentarios" runat="server">
                        <ItemTemplate>
                            <div class="comentario">
                                <p><strong>Usuario:</strong> <%# Eval("Usuario") %></p>
                                <p><%# Eval("Comentario") %></p>
                                <p><em><%# Eval("Fecha", "{0:yyyy-MM-dd HH:mm}") %></em></p>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>
        </div>

        <!-- Columna Derecha -->
        <div class="columna-derecha">
            <!-- Información del Departamento -->
            <div class="info-departamento">
                <h3 class="titulo-subseccion">Información del Departamento</h3>
                <p>
                    <strong>Precio:</strong>
                    <asp:Label ID="lblPrecio" runat="server"></asp:Label>
                </p>
                <p>
                    <strong>Ubicación:</strong>
                    <asp:Label ID="lblUbicacion" runat="server"></asp:Label>
                </p>
                <p>
                    <strong>Número de Habitaciones:</strong>
                    <asp:Label ID="lblHabitaciones" runat="server"></asp:Label>
                </p>
            </div>

            <!-- Normas -->
            <div class="info-contacto">
                <div class="normas-departamento">
                    <h3 class="titulo-subseccion">Normas</h3>
                    <p>
                        <strong>Estacionamiento:</strong>
                        <asp:Label ID="lblEstacionamiento" runat="server"></asp:Label>
                    </p>
                    <p>
                        <strong>Mascotas:</strong>
                        <asp:Label ID="lblMascotas" runat="server"></asp:Label>
                    </p>
                    <p>
                        <strong>Amueblado:</strong>
                        <asp:Label ID="lblAmueblado" runat="server"></asp:Label>
                    </p>
                </div>
            </div>

            <!-- Información de Contacto -->
            <div class="info-contacto">
                <h3 class="titulo-subseccion">Contacto</h3>
                <p>
                    <strong>Nombre:</strong>
                    <asp:Label ID="lblNombreContacto" runat="server"></asp:Label>
                </p>
                <p>
                    <strong>Teléfono:</strong>
                    <asp:Label ID="lblTelefono" runat="server"></asp:Label>
                </p>
                <p>
                    <strong>Correo Electrónico:</strong>
                    <asp:Label ID="lblCorreoContacto" runat="server"></asp:Label>
                </p>
            </div>

        </div>
    </div>

    <script>
        let currentIndex = 0;

        function mostrarImagen(index) {
            const images = document.querySelectorAll('.slider-imagen');
            images.forEach((img, i) => {
                img.style.display = i === index ? 'block' : 'none';
            });
        }

        function moverAnterior() {
            const images = document.querySelectorAll('.slider-imagen');
            currentIndex = (currentIndex - 1 + images.length) % images.length;
            mostrarImagen(currentIndex);
        }

        function moverSiguiente() {
            const images = document.querySelectorAll('.slider-imagen');
            currentIndex = (currentIndex + 1) % images.length;
            mostrarImagen(currentIndex);
        }

        document.addEventListener('DOMContentLoaded', () => mostrarImagen(currentIndex));
    </script>
</asp:Content>
