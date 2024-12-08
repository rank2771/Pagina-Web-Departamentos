<%@ Page Title="Registro Alumno" Language="C#" MasterPageFile="~/Pagina_Maestra/PaginaMaestra.Master" AutoEventWireup="true" CodeBehind="Pagina_Registro_Alumno.aspx.cs" Inherits="EjemploHerenciaPaginasWeb.Pagina_Maestra.Pagina_Registro_Alumno" %>

<asp:Content ID="ContentHead" ContentPlaceHolderID="head" runat="server">
    <!-- Puedes agregar aquí estilos o scripts específicos para esta página -->
    <configuration>
        <connectionstrings>
            <add name="MiConexion"
                connectionstring="Server=DESKTOP-GDTRFDM\SQLEXPRESS;Database=MiBaseDeDatos;Trusted_Connection=True;" providername="System.Data.SqlClient" />
        </connectionstrings>
    </configuration>
</asp:Content>

<asp:Content ID="ContentMain" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!--Hacemos referencia a nuestro CSS -->
    <link href="../Estilos/Registro_Alumno.css" rel="stylesheet" />
    <div class="login-container">
        <h2>Registro del Alumno</h2>
        <br>
        <!-- Etiqueta y campo para Nombre Completo -->
        <!-- Limita a 50 caracteres y permite al usuario ingresar únicamente -->
        <div class="form-group">
            <asp:Label ID="NombreCompleto" runat="server" Text="Nombre Completo:" CssClass="form-label"></asp:Label>
            <asp:TextBox ID="txtNombreCompleto" runat="server" CssClass="input-field" placeholder="Ingresa tu nombre completo" MaxLength="51"></asp:TextBox>
        </div>

        <!-- Etiqueta y campo para Numero de boleta -->
        <!-- Limita a 10 caracteres y permite al usuario ingresar únicamente  -->
        <div class="form-group">
            <asp:Label ID="lblNumeroBoleta" runat="server" Text="Número de Boleta:" CssClass="form-label"></asp:Label>
            <asp:TextBox ID="txtNumeroBoleta" runat="server" CssClass="input-field" placeholder="Ingresa tu número de boleta" MaxLength="10"></asp:TextBox>
        </div>

        <!-- Etiqueta y campo para Fecha de nacimiento -->
        <!-- Limita a 10 caracteres y permite al usuario ingresar únicamente  -->
        <div class="form-group">
            <asp:Label ID="lblFechaNacimiento" runat="server" Text="Fecha de Nacimiento:" CssClass="form-label"></asp:Label>
            <asp:TextBox ID="txtFechaNacimiento" runat="server" CssClass="input-field" placeholder="DD/MM/YYYY" MaxLength="10" TextMode="Date" onkeydown="return false;">></asp:TextBox>
        </div>

        <!-- Etiqueta y campo para Numero de telefono -->
        <!-- Limita a 10 caracteres y permite al usuario ingresar únicamente  -->
        <div class="form-group">
            <asp:Label ID="lblNumeroTelefono" runat="server" Text="Número de Teléfono:" CssClass="form-label"></asp:Label>
            <asp:TextBox ID="txtNumeroTelefono" runat="server" CssClass="input-field" placeholder="Ingresa tu número de teléfono" MaxLength="10" TextMode="Phone"></asp:TextBox>
        </div>

        <!-- Etiqueta y campo para Correo Electronico -->
        <!-- Limita a 50 caracteres y permite al usuario ingresar únicamente  -->
        <div class="form-group">
            <asp:Label ID="lblCorreoElectronico" runat="server" Text="Dirección de Correo Electrónico:" CssClass="form-label"></asp:Label>
            <asp:TextBox ID="txtCorreoElectronico" runat="server" CssClass="input-field" placeholder="Ingresa tu correo electrónico" MaxLength="50" TextMode="Email"></asp:TextBox>
        </div>

        <!-- Etiqueta y campo para Contraseña -->
        <!-- Limita a 16 caracteres y permite al usuario ingresar únicamente texto relevante -->
        <div class="form-group">
            <asp:Label ID="lblContrasena" runat="server" Text="Contraseña:" CssClass="form-label"></asp:Label>
            <asp:TextBox ID="txtContrasena" runat="server" CssClass="input-field" TextMode="Password" placeholder="Ingresa tu contraseña" MaxLength="16"></asp:TextBox>
        </div>

        <div class="button-container">
            <%-- Botón de redireccionamiento a la siguiente pagina --%>
            <asp:Button ID="btnGuardar" runat="server" Text="Registrarse" CssClass="custom-button" ValidateRequestMode="Inherit" OnClick="btnGuardar_Click" Width="178px" />
        </div>
    </div>

    <script type="text/javascript">
        // Validación general para todos los campos
        function validarCampos() {
            // Variables para capturar los valores de los campos
            const nombreCompleto = document.getElementById('<%= txtNombreCompleto.ClientID %>').value;
            const numeroBoleta = document.getElementById('<%= txtNumeroBoleta.ClientID %>').value;
            const fechaNacimiento = document.getElementById('<%= txtFechaNacimiento.ClientID %>').value;
            const numeroTelefono = document.getElementById('<%= txtNumeroTelefono.ClientID %>').value;
            const correoElectronico = document.getElementById('<%= txtCorreoElectronico.ClientID %>').value;
            const contrasena = document.getElementById('<%= txtContrasena.ClientID %>').value;

            // Llamadas a las funciones de validación
            if (
                !validarNombreCompleto(nombreCompleto) ||
                !validarNumeroBoleta(numeroBoleta) ||
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

        // Validación del número de boleta
        function validarNumeroBoleta(boleta) {
            const regex = /^[0-9]+$/; // Solo números permitidos
            if (boleta.trim() === "") {
                alert("Campo Inválido: El número de boleta no puede estar en blanco.");
                return false;
            }
            if (/\s/.test(boleta)) {
                alert("Campo Inválido: El número de boleta no puede contener espacios en blanco.");
                return false;
            }
            if (boleta.length !== 10) {
                alert("Campo Inválido: El número boleta tiene que tener 10 caracteres minimo.");
                return false;
            }
            if (!regex.test(boleta)) {
                alert("Campo Inválido: El número de boleta solo puede contener números.");
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
            const regex = /^[A-Za-z0-9._+-]+@alumno\.ipn\.mx$/; // Acepta caracteres permitidos y valida el dominio
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
                if (!correo.endsWith("@alumno.ipn.mx")) {
                    alert("Campo Inválido: El dominio del correo debe ser @alumno.ipn.mx.");
                } else {
                    alert("Campo Inválido: El correo electrónico tiene un formato incorrecto.");
                }
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
        document.getElementById('<%= btnGuardar.ClientID %>').onclick = function (event) {
            if (!validarCampos()) {
                event.preventDefault(); // Evitar envío del formulario si hay errores
            }
        };
    </script>
</asp:Content>