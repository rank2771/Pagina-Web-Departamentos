<%@ Page Title="Publicar Caracteristicas" Language="C#" MasterPageFile="~/Pagina_Maestra/PaginaMaestra.Master" AutoEventWireup="true" CodeBehind="Menu_Arrendador_Publicar_Caracteristicas.aspx.cs" Inherits="EjemploHerenciaPaginasWeb.Pagina_Maestra.Menu_Arrendador_Publicar_Caracteristicas" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="../Estilos/Menu_Arrendador_Publicar_Caracteristicas.css" rel="stylesheet" />


    <div class="login-container">
        <h1>Agregar Departamento</h1>
        <h2>CARACTERÍSTICAS. </h2>

        <div class="form-group">
            <!-- Campo para agregar información breve -->
            <asp:Label ID="InformacionBreve" runat="server" Text="Información Departamento:" CssClass="form-label"></asp:Label>
            <asp:TextBox ID="txtInformacionBreve" runat="server" Placeholder="Información breve del departamento" CssClass="input-field"></asp:TextBox>
            <br />
        </div>

        <div class="form-group">
            <!-- Campo para agregar el precio -->
            <asp:Label ID="Precio" runat="server" Text="Precio:" CssClass="form-label"></asp:Label>
            <asp:TextBox ID="txtPrecio" runat="server" Placeholder="Precio del departamento" CssClass="input-field" MaxLength="10"></asp:TextBox>
            <br />
        </div>

        <%--Número de recamaras--%>
        <div class="form-group">
            <label for="Correo" class="form-label">Número de Recámaras: </label>
            <asp:TextBox ID="txtNumeroRecamaras" runat="server" placeholder="Número de Recámaras" CssClass="input-field" MaxLength="1"></asp:TextBox>
            <asp:Label ID="lblErrorRecamaras" runat="server" CssClass="error-message" Visible="false"></asp:Label>
        </div>

        <%--Número de baños--%>
        <div class="form-group">
            <label for="txtNumeroBanos" class="form-label">Número de Baños: </label>
            <asp:TextBox ID="txtNumeroBanos" runat="server" placeholder="Número de Baños" CssClass="input-field" MaxLength="1"></asp:TextBox>
            <asp:Label ID="lblErrorBanos" runat="server" CssClass="error-message" Visible="false"></asp:Label>
        </div>

        <%--Estacionamiento--%>
        <div class="form-group">
            <label for="txtEstacionamiento" class="form-label">Estacionamiento (1=Sí, 0=No):</label>
            <asp:TextBox ID="txtEstacionamiento" runat="server" placeholder="1 o 0" CssClass="input-field" MaxLength="1"></asp:TextBox>
            <asp:Label ID="lblErrorEstacionamiento" runat="server" CssClass="error-message" Visible="false"></asp:Label>
        </div>

        <%--Mascotas --%>
        <div class="form-group">
            <label for="txtMascotas" class="form-label">Mascotas (1=Sí, 0=No):</label>
            <asp:TextBox ID="txtMascotas" runat="server" placeholder="1 o 0" CssClass="input-field" MaxLength="1"></asp:TextBox>
            <asp:Label ID="lblErrorMascotas" runat="server" CssClass="error-message" Visible="false"></asp:Label>
        </div>

        <%--Amueblado--%>
        <div class="form-group">
            <label for="txtAmueblado" class="form-label">Amueblado (1=Sí, 0=No):</label>
            <asp:TextBox ID="txtAmueblado" runat="server" placeholder="1 o 0" CssClass="input-field" MaxLength="1"></asp:TextBox>
            <asp:Label ID="lblErrorAmueblado" runat="server" CssClass="error-message" Visible="false"></asp:Label>
        </div>

        <%--Botón Confirmar Características--%>
        <div class="button-container">
            <asp:Button ID="btnConfirmarCaracteristicas" runat="server" Text="Continuar" CssClass="custom-button" OnClick="BtnConfirmarCaracteristicas_Click" />
        </div>
    </div>

    <script type="text/javascript">
    // Validación general para las características del departamento
    function validarCamposCaracteristicas() {
        // Captura de valores de los campos
        const informacionBreve = document.getElementById('<%= txtInformacionBreve.ClientID %>').value;
        const precio = document.getElementById('<%= txtPrecio.ClientID %>').value;
        const numeroRecamaras = document.getElementById('<%= txtNumeroRecamaras.ClientID %>').value;
        const numeroBanos = document.getElementById('<%= txtNumeroBanos.ClientID %>').value;
        const estacionamiento = document.getElementById('<%= txtEstacionamiento.ClientID %>').value;
        const mascotas = document.getElementById('<%= txtMascotas.ClientID %>').value;
        const amueblado = document.getElementById('<%= txtAmueblado.ClientID %>').value;

        // Validación de cada campo
        if (!validarInformacionBreve(informacionBreve)) return false;
        if (!validarPrecio(precio)) return false;
        if (!validarNumeroEntero(numeroRecamaras, "Número de Recámaras")) return false;
        if (!validarNumeroEntero(numeroBanos, "Número de Baños")) return false;
        if (!validarBooleano(estacionamiento, "Estacionamiento")) return false;
        if (!validarBooleano(mascotas, "Mascotas")) return false;
        if (!validarBooleano(amueblado, "Amueblado")) return false;

        return true; // Si todos los campos son válidos
    }

    // Validación del campo de información breve
    function validarInformacionBreve(valor) {
        const regex = /^[A-Za-z0-9\s,\.\-\/#áéíóúüÁÉÍÓÚÜ]+$/;
        if (valor.trim() === "") {
            alert("Campo Inválido: El campo Información Departamento no puede estar vacío.");
            return false;
        }
        if (!regex.test(valor)) {
            alert("Campo Inválido: Caracter inválido en el campo Información Departamento.");
            return false;
        }
        return true;
    }

    // Validación del precio
function validarPrecio(valor) {
    if (valor.trim() === "") {
        alert("Campo Inválido: El campo Precio no puede estar vacío.");
        return false;
    }
    // Expresión regular para validar números decimales
    const regex = /^[0-9]+(\.[0-9]{1,2})?$/; // Solo números enteros o decimales con hasta 2 dígitos decimales
    if (!regex.test(valor)) {
        alert("Campo Inválido: El precio debe ser un número válido con hasta 2 decimales.");
        return false;
    }
    const precio = parseFloat(valor);
    if (precio < 0 || precio > 99999999.99) {
        alert("Campo Inválido: El precio debe estar entre 0 y 99,999,999.99.");
        return false;
    }
    return true;
}


    // Validación de números enteros
    function validarNumeroEntero(valor, nombreCampo) {
        if (valor.trim() === "") {
            alert(`Campo Inválido: El campo ${nombreCampo} no puede estar vacío.`);
            return false;
        }
        if (!/^[0-9]+$/.test(valor)) {
            alert(`Campo Inválido: El campo ${nombreCampo} debe contener solo números enteros.`);
            return false;
        }
        return true;
    }

    // Validación de valores booleanos
    function validarBooleano(valor, nombreCampo) {
        if (valor.trim() === "") {
            alert(`Campo Inválido: El campo ${nombreCampo} no puede estar vacío.`);
            return false;
        }
        if (!/^[01]$/.test(valor)) {
            alert(`Campo Inválido: El campo ${nombreCampo} debe ser 1 (Sí) o 0 (No).`);
            return false;
        }
        return true;
    }

    // Asociar la validación al botón de confirmar
    document.getElementById('<%= btnConfirmarCaracteristicas.ClientID %>').onclick = function(event) {
        if (!validarCamposCaracteristicas()) {
            event.preventDefault(); // Detener el envío si hay errores
        }
    };
    </script>


</asp:Content>
