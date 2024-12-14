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
                        <img src='<%# Eval("ImagenBase64") %>' alt="Imagen del Departamento" class="slider-imagen" onclick="openModal(this)" />
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

    <div id="modal" class="modal">
        <span class="close" onclick="closeModal()">&times;</span>
        <img id="modalImage" class="modal-content" />
        <span class="prev" onclick="showPrevImage()">&#10094;</span>
        <!-- Flecha izquierda -->
        <span class="next" onclick="showNextImage()">&#10095;</span>
        <!-- Flecha derecha -->
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

        let currentImageIndex = 0; // Índice de la imagen actual
        let images = []; // Array de imágenes

        // Función para inicializar el array de imágenes al cargar la página
        function initializeImages() {
            const imageElements = document.querySelectorAll('.slider-imagen'); // Todas las imágenes del Repeater
            images = Array.from(imageElements); // Convertimos NodeList a Array
        }

        // Función para abrir el modal
        function openModal(img) {
            const modal = document.getElementById("modal");
            const modalImg = document.getElementById("modalImage");
            modal.style.display = "block"; // Mostrar el modal
            modalImg.src = img.src; // Mostrar la imagen seleccionada
            currentImageIndex = images.findIndex(image => image.src === img.src); // Establecer índice actual
            // Agregar el evento de teclado solo cuando el modal esté abierto
            document.addEventListener("keydown", handleKeyboardNavigation);
        }

        // Función para cerrar el modal
        function closeModal() {
            const modal = document.getElementById("modal");
            modal.style.display = "none"; // Ocultar el modal
            // Eliminar el evento de teclado al cerrar el modal
            document.removeEventListener("keydown", handleKeyboardNavigation);
        }

        // Función para mostrar la imagen anterior
        function showPrevImage() {
            currentImageIndex = (currentImageIndex - 1 + images.length) % images.length; // Navegar al índice anterior
            const modalImg = document.getElementById("modalImage");
            modalImg.src = images[currentImageIndex].src; // Mostrar la imagen anterior
            updateCounter(); // (Si tienes un contador, lo actualiza)
        }

        // Función para mostrar la imagen siguiente
        function showNextImage() {
            currentImageIndex = (currentImageIndex + 1) % images.length; // Navegar al índice siguiente
            const modalImg = document.getElementById("modalImage");
            modalImg.src = images[currentImageIndex].src; // Mostrar la imagen siguiente
            updateCounter(); // (Si tienes un contador, lo actualiza)
        }

        // Llama a esta función al cargar la página
        initializeImages();

        //document.addEventListener("keydown", function (event) {
        //    if (event.key === "Escape") {
        //        closeModal(); // Cierra el modal si se presiona ESC
        //    }
        //});

        function handleKeyboardNavigation(event) {
            if (event.key === "ArrowLeft") {
                showPrevImage(); // Muestra la imagen anterior con la flecha izquierda
            } else if (event.key === "ArrowRight") {
                showNextImage(); // Muestra la imagen siguiente con la flecha derecha
            } else if (event.key === "Escape") {
                closeModal(); // Cierra el modal con la tecla Escape
            }
        }


    </script>
</asp:Content>
