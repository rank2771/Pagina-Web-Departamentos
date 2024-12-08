using EjemploHerenciaPaginasWeb.Helpers;
using System;
using System.Data.SqlClient;
using System.Net.Mail;
using System.Net;

namespace EjemploHerenciaPaginasWeb.Pagina_Maestra
{
    public partial class Pagina_Recuperar_contrasena : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void BtnEnviar_Click(object sender, EventArgs e)
        {
            string correo = Correo_Recuperacion.Text.Trim();

            // Verificar si el correo existe y obtener la contraseña
            string contrasena = ObtenerContrasenaPorCorreo(correo);
            //Enviar Correo
            string toEmail = correo; // Correo del destinatario
            string subject = "Codigo de Veirificacion de Correo";        // Asunto del correo
            string messageBody = "Tu contraseña es la siguiente: " + contrasena;  // Cuerpo del mensaje
            try
            {
                // Configuración del servidor SMTP
                SmtpClient smtpClient = new SmtpClient("smtp.gmail.com", 587);
                smtpClient.Credentials = new NetworkCredential("wasdsoftwaredev@gmail.com", "ofkb fesa jtyd tawn");
                smtpClient.EnableSsl = true;
                MailMessage mailMessage = new MailMessage();
                mailMessage.From = new MailAddress("tu_correo@gmail.com");
                mailMessage.To.Add(toEmail);
                mailMessage.Subject = subject;
                mailMessage.Body = messageBody;

                // Enviar el correo
                smtpClient.Send(mailMessage);

                Response.Write("<script>alert('Correo enviado exitosamente.');</script>");

                // Redirigir a la página de verificación de correo
                Response.Redirect("~/Pagina_Maestra/Inicio_Sesion.aspx");
            }
            catch (Exception ex)
            {
                Response.Write($"<script>alert('Error al enviar el correo: {ex.Message}');</script>");
            }
        }
        private string ObtenerContrasenaPorCorreo(string correo)
        {
            string query = @"
                SELECT Contraseña
                FROM Usuario
                WHERE Correo = @Correo
                UNION
                SELECT Contrasenia
                FROM RegistroArrendador
                WHERE DireccionCorreo = @Correo";
            SqlParameter[] parameters = {
                new SqlParameter("@Correo", correo)
            };

            try
            {
                // Usar el método ExecuteScalar de la clase Conexion
                object resultado = Conexion.ExecuteScalar(query, parameters);

                return resultado != null ? resultado.ToString() : null;
            }
            catch (Exception ex)
            {
                // Manejo de errores
                Response.Write($"<script>alert('Error: {ex.Message}');</script>");
                return null;
            }
        }
    }
}