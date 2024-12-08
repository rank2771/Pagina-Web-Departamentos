using EjemploHerenciaPaginasWeb.Helpers;
using System;
using System.Data.SqlClient;
using System.Net.Mail;
using System.Net;

namespace EjemploHerenciaPaginasWeb
{
    public partial class Arrendador : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection connection = Conexion.GetOpenConnection())
                {
                   
                }
            }
            catch (Exception ex)
            {
                Response.Write("Error: " + ex.Message);
            }
        }

        public int GenerarNumeroAleatorio()
        {
            Random random = new Random();
            int numeroAleatorio = random.Next(100000, 1000000); // Genera un número entre 100000 y 999999
            return numeroAleatorio;
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            // Capturar los valores de los TextBox
            string nombre = TxtNombre.Text;
            string curp = TxtCURP.Text;
            DateTime fechaNacimiento = DateTime.Parse(TxtFechaNacimiento.Text);
            string numeroTelefono = TxtTelefono.Text;
            string direccionCorreo = TxtCorreo.Text;
            string contrasenia = TxtContrasena.Text;
            int codigoVerificacion = GenerarNumeroAleatorio();

            // Validar que no haya campos vacíos
            if (string.IsNullOrEmpty(nombre) || string.IsNullOrEmpty(curp) ||
                string.IsNullOrEmpty(numeroTelefono) ||
                string.IsNullOrEmpty(direccionCorreo) || string.IsNullOrEmpty(contrasenia))
            {
                Response.Write("<script>alert('Por favor, complete todos los campos.');</script>");
                return;
            }

            try
            {
                // Verificar si el CURP o el correo ya existen
                string queryVerificar = @"
                    SELECT COUNT(*) FROM RegistroArrendador 
                    WHERE Curp = @Curp OR DireccionCorreo = @DireccionCorreo";

                SqlParameter[] verificarParams = {
                    new SqlParameter("@Curp", curp),
                    new SqlParameter("@DireccionCorreo", direccionCorreo)
                };

                using (SqlConnection connection = Conexion.GetOpenConnection())
                {
                    SqlCommand verificarCommand = new SqlCommand(queryVerificar, connection);
                    verificarCommand.Parameters.AddRange(verificarParams);

                    int existe = Convert.ToInt32(verificarCommand.ExecuteScalar());
                    if (existe > 0)
                    {
                        Response.Write("<script>alert('El CURP o el correo ya están registrados.');</script>");
                        return;
                    }
                }

                // Consulta SQL para insertar datos
                string queryInsertar = @"INSERT INTO RegistroArrendador 
                        (Nombre, Curp, FechaNacimiento, NumeroTelefono, DireccionCorreo, Contrasenia, Codigo)
                        VALUES (@Nombre, @Curp, @FechaNacimiento, @NumeroTelefono, @DireccionCorreo, @Contrasenia, @Codigo)";

                SqlParameter[] insertParams = {
                    new SqlParameter("@Nombre", nombre),
                    new SqlParameter("@Curp", curp),
                    new SqlParameter("@FechaNacimiento", fechaNacimiento),
                    new SqlParameter("@NumeroTelefono", numeroTelefono),
                    new SqlParameter("@DireccionCorreo", direccionCorreo),
                    new SqlParameter("@Contrasenia", contrasenia),
                    new SqlParameter("@Codigo", codigoVerificacion)
                };

                int rowsAffected = Conexion.ExecuteNonQuery(queryInsertar, insertParams);

                if (rowsAffected > 0)
                {
                    // Enviar correo
                    string toEmail = TxtCorreo.Text;
                    string subject = "Código de Verificación de Correo";
                    string messageBody = "Tu código de verificación para registrar tu cuenta es el siguiente: " + codigoVerificacion;

                    try
                    {
                        // Configuración del servidor SMTP
                        SmtpClient smtpClient = new SmtpClient("smtp.gmail.com", 587)
                        {
                            Credentials = new NetworkCredential("wasdsoftwaredev@gmail.com", "ofkb fesa jtyd tawn"),
                            EnableSsl = true
                        };
                        MailMessage mailMessage = new MailMessage
                        {
                            From = new MailAddress("wasdsoftwaredev@gmail.com"),
                            Subject = subject,
                            Body = messageBody
                        };
                        mailMessage.To.Add(toEmail);

                        smtpClient.Send(mailMessage);

                        Response.Write("<script>alert('Correo enviado exitosamente.');</script>");

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
                    Response.Write("<script>alert('No se pudo insertar el registro. Inténtelo de nuevo.');</script>");
                }
            }
            catch (Exception ex)
            {
                // Mostrar el error
                Response.Write($"<script>alert('Error al insertar el registro: {ex.Message}');</script>");
            }
        }
    }
}
