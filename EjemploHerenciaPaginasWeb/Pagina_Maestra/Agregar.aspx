<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Agregar.aspx.cs" Inherits="EjemploHerenciaPaginasWeb.Pagina_Maestra.Agregar" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Agregar Departamento</title>
    <style>
        /*Esta es una prueba en nuestro nuevo formato de nuestro documento*/
        .form-container {
            max-width: 600px;
            margin: auto;
            padding: 20px;
            border: 1px solid #ccc;
            background-color: #f9f9f9;
            border-radius: 10px;
        }
        .form-container h2 {
            text-align: center;
        }
        .form-container label {
            display: block;
            margin-top: 10px;
            font-weight: bold;
        }
        .form-container input[type="text"],
        .form-container textarea {
            width: 100%;
            padding: 8px;
            margin: 5px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .form-container input.error,
        .form-container textarea.error {
            border: 1px solid red;
        }
        .form-container .error-message {
            color: red;
            font-size: 12px;
            margin-top: -5px;
            margin-bottom: 10px;
        }
        .form-container button {
            display: block;
            width: 100%;
            padding: 10px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-top: 20px;
        }
        .form-container button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

    <form id="formAgregarDepartamento" runat="server">
        
        <asp:Label ID="lblCorreo" runat="server" Text="El correo aparecerá aquí"></asp:Label>
        <div class="form-container">
            <h2>Agregar Departamento</h2>

            <label for="txtFotoDepartamento">Foto del Departamento:</label>
             <asp:FileUpload ID="fileFotoDepartamento" runat="server" CssClass="form-control" />
            <asp:Label ID="lblErrorFoto" runat="server" CssClass="error-message" Visible="false"></asp:Label>

            <label for="txtPrecio">Precio:</label>
            <asp:TextBox ID="txtPrecio" runat="server" placeholder="Precio del departamento"></asp:TextBox>
            <asp:Label ID="lblErrorPrecio" runat="server" CssClass="error-message" Visible="false"></asp:Label>

            <label for="txtInformacionBreve">Información Breve:</label>
            <asp:TextBox ID="txtInformacionBreve" runat="server" TextMode="MultiLine" placeholder="Breve descripción"></asp:TextBox>
            <asp:Label ID="lblErrorInfoBreve" runat="server" CssClass="error-message" Visible="false"></asp:Label>

            <label for="txtCalle">Calle:</label>
            <asp:TextBox ID="txtCalle" runat="server" placeholder="Calle"></asp:TextBox>
            <asp:Label ID="lblErrorCalle" runat="server" CssClass="error-message" Visible="false"></asp:Label>

            <label for="txtColonia">Colonia:</label>
            <asp:TextBox ID="txtColonia" runat="server" placeholder="Colonia"></asp:TextBox>
            <asp:Label ID="lblErrorColonia" runat="server" CssClass="error-message" Visible="false"></asp:Label>

            <label for="txtCiudad">Ciudad:</label>
            <asp:TextBox ID="txtCiudad" runat="server" placeholder="Ciudad"></asp:TextBox>
            <asp:Label ID="lblErrorCiudad" runat="server" CssClass="error-message" Visible="false"></asp:Label>

            <label for="txtMunicipio">Municipio:</label>
            <asp:TextBox ID="txtMunicipio" runat="server" placeholder="Municipio"></asp:TextBox>
            <asp:Label ID="lblErrorMunicipio" runat="server" CssClass="error-message" Visible="false"></asp:Label>

            <label for="txtNumeroRecamaras">Número de Recámaras:</label>
            <asp:TextBox ID="txtNumeroRecamaras" runat="server" placeholder="Número de Recámaras"></asp:TextBox>
            <asp:Label ID="lblErrorRecamaras" runat="server" CssClass="error-message" Visible="false"></asp:Label>

            <label for="txtNumeroBanos">Número de Baños:</label>
            <asp:TextBox ID="txtNumeroBanos" runat="server" placeholder="Número de Baños"></asp:TextBox>
            <asp:Label ID="lblErrorBanos" runat="server" CssClass="error-message" Visible="false"></asp:Label>

            <label for="txtEstacionamiento">Estacionamiento (1=Sí, 0=No):</label>
            <asp:TextBox ID="txtEstacionamiento" runat="server" placeholder="1 o 0"></asp:TextBox>
            <asp:Label ID="lblErrorEstacionamiento" runat="server" CssClass="error-message" Visible="false"></asp:Label>

            <label for="txtMascotas">Mascotas (1=Sí, 0=No):</label>
            <asp:TextBox ID="txtMascotas" runat="server" placeholder="1 o 0"></asp:TextBox>
            <asp:Label ID="lblErrorMascotas" runat="server" CssClass="error-message" Visible="false"></asp:Label>

            <label for="txtAmueblado">Amueblado (1=Sí, 0=No):</label>
            <asp:TextBox ID="txtAmueblado" runat="server" placeholder="1 o 0"></asp:TextBox>
            <asp:Label ID="lblErrorAmueblado" runat="server" CssClass="error-message" Visible="false"></asp:Label>

            <button type="submit" runat="server" OnServerClick="btnAgregar_Click">Agregar Departamento</button>
        </div>
    </form>
</body>
</html>
