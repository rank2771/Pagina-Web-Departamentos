<%@ Page Title="Registro Arrendador" Language="C#" MasterPageFile="~/Pagina_Maestra/PaginaMaestra.Master" AutoEventWireup="true" CodeBehind="Pagina_Registro_Arrendador.aspx.cs" Inherits="EjemploHerenciaPaginasWeb.Arrendador" %>

<asp:Content ID="ContentHead" ContentPlaceHolderID="head" runat="server">
    <!-- Puedes agregar aquí estilos o scripts específicos para esta página -->
</asp:Content>

<asp:Content ID="ContentMain" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Hacemos referencia a nuestro CSS -->
    <link href="../Estilos/Registro_Arrendador.css" rel="stylesheet" />

    <div class="login-container" >
        <h2>Registro del Arrendador</h2>
        <!-- Campo para Nombre Completo -->
        <div class="form-group">
            <asp:Label ID="NombreCompleto" runat="server" Text="Nombre Completo:" CssClass="form-label"></asp:Label>
            <asp:TextBox ID="TxtNombre" runat="server" placeholder="Ingresa tu nombre completo" MaxLength="50" CssClass="input-field"></asp:TextBox>
        </div>
        <!-- Campo para CURP -->
        <div class="form-group">
            <asp:Label ID="curp" runat="server" Text="CURP:" CssClass="form-label"></asp:Label>
            <asp:TextBox ID="TxtCURP" runat="server" CssClass="input-field" placeholder="Ingresa tu CURP" MaxLength="18"></asp:TextBox>
        </div>

        <!-- Campo para Fecha de Nacimiento -->
        <div class="form-group">
            <asp:Label ID="fechaNacimiento" runat="server" Text="Fecha de Nacimiento:" CssClass="form-label"></asp:Label>
            <asp:TextBox ID="TxtFechaNacimiento" runat="server" CssClass="input-field" placeholder="DD/MM/YYYY" MaxLength="50" TextMode="Date" onkeydown="return false;"></asp:TextBox>
        </div>
        <!-- Campo para Número de Teléfono -->
        <div class="form-group">
            <asp:Label ID="telefono" runat="server" Text="Número de Teléfono:" CssClass="form-label"></asp:Label>
            <asp:TextBox ID="TxtTelefono" runat="server" CssClass="input-field" placeholder="Ingresa tu número de teléfono" MaxLength="10"></asp:TextBox>
        </div>
        <!-- Campo para Dirección de Correo Electrónico -->
        <div class="form-group">
            <asp:Label ID="correo" runat="server" Text="Dirección de Correo Electrónico:" CssClass="form-label"></asp:Label>
            <asp:TextBox ID="TxtCorreo" runat="server" CssClass="input-field" placeholder="Ingresa tu correo electrónico" MaxLength="50"></asp:TextBox>
        </div>
        <!-- Campo para Contraseña -->
        <div class="form-group">
            <asp:Label ID="contrasena" runat="server" Text="Contraseña:" CssClass="form-label"></asp:Label>
            <asp:TextBox ID="TxtContrasena" runat="server" CssClass="input-field" placeholder="Ingresa tu contraseña" MaxLength="16" TextMode="Password"></asp:TextBox>
        </div>
        <!-- Botón de Registro -->
        <div class="button-container">
            <asp:Button ID="BtnRegistrar" runat="server" Text="Registrarse" CssClass="custom-button" OnClick="btnGuardar_Click" />
        </div>
    </div>


    <script type="text/javascript">
        // Validación general para todos los campos
        function validarCampos() {
            // Variables para capturar los valores de los campos
            const nombreCompleto = document.getElementById('<%= TxtNombre.ClientID %>').value;
            const curp = document.getElementById('<%= TxtCURP.ClientID %>').value;
            const fechaNacimiento = document.getElementById('<%= TxtFechaNacimiento.ClientID %>').value;
            const numeroTelefono = document.getElementById('<%= TxtTelefono.ClientID %>').value;
            const correoElectronico = document.getElementById('<%= TxtCorreo.ClientID %>').value;
            const contrasena = document.getElementById('<%= TxtContrasena.ClientID %>').value;

            // Llamadas a las funciones de validación
            if (
                !validarNombreCompleto(nombreCompleto) ||
                !validarCURP(curp) ||
                !validarFechaNacimiento(fechaNacimiento) ||
                !validarNumeroTelefono(numeroTelefono) ||
                !validarCorreoElectronico(correoElectronico) ||
                !validarContrasena(contrasena)
            ) {
                return false; // Si hay un error, detener el envío del formulario
            }
            return true;
        }

        // Validación del nombre completo
        function validarNombreCompleto(nombre) {
            const regex = /^[A-Za-z\s]+$/; // Acepta solo letras y espacios
            if (nombre.trim() === "") {
                alert("Campo Inválido: El nombre no puede estar en blanco.");
                return false;
            }
            if (nombre.length > 50) {
                alert("Campo Inválido: El nombre no puede exceder los 50 caracteres.");
                return false;
            }
            if (!regex.test(nombre)) {
                alert("Campo Inválido: El nombre solo puede contener letras y espacios.");
                return false;
            }
            return true;
        }

        // Validación del CURP
        function validarCURP(curp) {
            const regex = /^[A-Z]{4}\d{6}[A-Z0-9]{8}$/; // Valida la estructura del CURP
            if (curp.trim() === "") {
                alert("Campo Inválido: El CURP no puede estar en blanco.");
                return false;
            }
            if (curp.length !== 18) {
                alert("Campo Inválido: El CURP debe tener exactamente 18 caracteres.");
                return false;
            }
            if (/\s/.test(curp)) {
                alert("Campo Inválido: El CURP no puede contener espacios en blanco.");
                return false;
            }
            if (!regex.test(curp)) {
                alert("Campo Inválido: El CURP debe cumplir con el formato correcto (4 letras, 6 dígitos de fecha de nacimiento, 8 caracteres alfanuméricos).");
                return false;
            }
            return true;
        }

        // Validación de la fecha de nacimiento
        function validarFechaNacimiento(fechaNacimiento) {
            if (fechaNacimiento.trim() === "") {
                alert("Campo Inválido: La fecha de nacimiento no puede estar en blanco.");
                return false;
            }
            if (/\s/.test(fechaNacimiento)) {
                alert("Campo Inválido: La fecha de nacimiento no puede contener espacios en blanco.");
                return false;
            }
            if (fechaNacimiento.length > 10) {
                alert("Campo Inválido: La fecha de nacimiento no puede exceder los 10 caracteres.");
                return false;
            }
            return true;
        }

        // Validación del número de teléfono
        function validarNumeroTelefono(numeroTelefono) {
            const regex = /^[0-9]+$/; // Solo números permitidos
            if (numeroTelefono.trim() === "") {
                alert("Campo Inválido: El número de teléfono no puede estar en blanco.");
                return false;
            }
            if (/\s/.test(numeroTelefono)) {
                alert("Campo Inválido: El número de teléfono no puede contener espacios en blanco.");
                return false;
            }
            if (numeroTelefono.length !== 10) {
                alert("Campo Inválido: El número de teléfono tiene que tener 10 caracteres minimo.");
                return false;
            }
            if (!regex.test(numeroTelefono)) {
                alert("Campo Inválido: El número de teléfono solo puede contener números.");
                return false;
            }
            return true;
        }

        // Validación del correo electrónico
        function validarCorreoElectronico(correo) {
            const regex = /^[A-Za-z0-9](?!.*\.\.)([A-Za-z0-9._+-])*@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$/; // Ajustada para prevenir puntos al inicio
            if (correo.trim() === "") {
                alert("Campo Inválido: El correo electrónico no puede estar en blanco.");
                return false;
            }
            if (/\s/.test(correo)) {
                alert("Campo Inválido: El correo electrónico no puede contener espacios en blanco.");
                return false;
            }
            if (correo.length > 50) {
                alert("Campo Inválido: El correo electrónico no puede exceder los 50 caracteres.");
                return false;
            }
            if (!regex.test(correo)) {
                alert("Campo Inválido: El correo electrónico tiene un formato inválido.");
                return false;
            }
            return true;
        }


        // Validación de la contraseña
        function validarContrasena(contrasena) {
            const regex = /^[A-Za-z0-9@#$%!&!?*_.+=^-]{8,16}$/; // Acepta caracteres permitidos y longitud
            if (contrasena.trim() === "") {
                alert("Campo Inválido: La contraseña no puede estar en blanco.");
                return false;
            }
            if (/\s/.test(contrasena)) {
                alert("Campo Inválido: La contraseña no puede contener espacios en blanco.");
                return false;
            }
            if (contrasena.length < 8 || contrasena.length > 16) {
                alert("Campo Inválido: La contraseña debe tener entre 8 y 16 caracteres.");
                return false;
            }
            if (!regex.test(contrasena)) {
                alert("Campo Inválido: La contraseña contiene caracteres no permitidos.");
                return false;
            }
            return true;
        }

        // Llamar a la validación al hacer clic en el botón
        document.getElementById('<%= BtnRegistrar.ClientID %>').onclick = function (event) {
            if (!validarCampos()) {
                event.preventDefault(); // Evitar envío del formulario si hay errores
            }
        };
    </script>

</asp:Content>
