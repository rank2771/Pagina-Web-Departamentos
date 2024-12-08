using EjemploHerenciaPaginasWeb.Helpers;
using System;
using System.Data.SqlClient;
using System.Net.Mail;
using System.Net;
using System.Web.UI;

namespace EjemploHerenciaPaginasWeb.Pagina_Maestra
{
    public partial class Pagina_Registro_Alumno : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {
                    using (SqlConnection connection = Conexion.GetOpenConnection())
                    {
                        // Verificar conexión con la base de datos
                    }
                }
                catch (Exception ex)
                {
                    Response.Write("Error: " + ex.Message);
                }
            }
        }

        public int GenerarNumeroAleatorio()
        {
            Random random = new Random();
            return random.Next(100000, 1000000); // Genera un número entre 100000 y 999999
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            // Recoger datos del formulario
            string nombre = txtNombreCompleto.Text.Trim();
            string boleta = txtNumeroBoleta.Text.Trim();
            string nacimiento = txtFechaNacimiento.Text.Trim();
            string telefono = txtNumeroTelefono.Text.Trim();
            string correo = txtCorreoElectronico.Text.Trim();
            string contrasena = txtContrasena.Text.Trim();
            int codigoVerificacion = GenerarNumeroAleatorio();

            // Validar que no haya campos vacíos
            if (string.IsNullOrEmpty(nombre) || string.IsNullOrEmpty(boleta) ||
                string.IsNullOrEmpty(nacimiento) || string.IsNullOrEmpty(telefono) ||
                string.IsNullOrEmpty(correo) || string.IsNullOrEmpty(contrasena))
            {
                Response.Write("<script>alert('Por favor, complete todos los campos.');</script>");
                return;
            }

            try
            {
                // Verificar si el correo o la boleta ya existen en la base de datos
                string verificarQuery = @"SELECT COUNT(*) FROM Usuario WHERE Correo = @Correo OR Boleta = @Boleta";

                SqlParameter[] verificarParams = {
                    new SqlParameter("@Correo", correo),
                    new SqlParameter("@Boleta", boleta)
                };

                int registrosExistentes = (int)Conexion.ExecuteScalar(verificarQuery, verificarParams);

                if (registrosExistentes > 0)
                {
                    // Mostrar mensaje de alerta si ya existe un registro con el mismo correo o boleta
                    Response.Write("<script>alert('El correo o la boleta ya están registrados. Por favor, use datos diferentes.');</script>");
                    return;
                }

                // Crear la consulta SQL para insertar
                string query = "INSERT INTO Usuario (Nombre, Boleta, FechaNacimiento, Telefono, Correo, Contraseña, Codigo) " +
                               "VALUES (@Nombre, @Boleta, @FechaNacimiento, @Telefono, @Correo, @Contraseña, @Codigo)";

                SqlParameter[] parameters = {
                    new SqlParameter("@Nombre", nombre),
                    new SqlParameter("@Boleta", boleta),
                    new SqlParameter("@FechaNacimiento", nacimiento),
                    new SqlParameter("@Telefono", telefono),
                    new SqlParameter("@Correo", correo),
                    new SqlParameter("@Contraseña", contrasena),
                    new SqlParameter("@Codigo", codigoVerificacion)
                };

                int rowsAffected = Conexion.ExecuteNonQuery(query, parameters);

                if (rowsAffected > 0)
                {
                    // Enviar correo con el código de verificación
                    string toEmail = correo;
                    string subject = "Código de Verificación de Correo";
                    string messageBody = $"Tu código de verificación para registrar tu cuenta es el siguiente: {codigoVerificacion}";

                    try
                    {
                        SmtpClient smtpClient = new SmtpClient("smtp.gmail.com", 587);
                        smtpClient.Credentials = new NetworkCredential("wasdsoftwaredev@gmail.com", "ofkb fesa jtyd tawn");
                        smtpClient.EnableSsl = true;

                        MailMessage mailMessage = new MailMessage
                        {
                            From = new MailAddress("wasdsoftwaredev@gmail.com"),
                            Subject = subject,
                            Body = messageBody
                        };
                        mailMessage.To.Add(toEmail);

                        smtpClient.Send(mailMessage);

                        Response.Write("<script>alert('Registro exitoso. Correo de verificación enviado.');</script>");
                        Session["UserType"] = "Alumno";

                        // Redirigir a la página de verificación de correo
                        Response.Redirect("~/Pagina_Maestra/Pagina_Verificacion_de_correo.aspx");
                    }
                    catch (Exception ex)
                    {
                        Response.Write($"<script>alert('Error al enviar el correo: {ex.Message}');</script>");
                    }
                }
                else
                {
                    Response.Write("<script>alert('No se pudo completar el registro. Inténtelo de nuevo.');</script>");
                }
            }
            catch (Exception ex)
            {
                Response.Write($"<script>alert('Error al procesar el registro: {ex.Message}');</script>");
            }
        }
    }
}
