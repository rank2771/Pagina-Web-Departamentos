using EjemploHerenciaPaginasWeb.Helpers;
using System;
using System.Data.SqlClient;

namespace EjemploHerenciaPaginasWeb
{
    public partial class login : System.Web.UI.Page
    {
        protected void BTNLogin_Click(object sender, EventArgs e)
        {
            // Recoger datos del formulario de inicio de sesión
            string correo = Correo_1.Text.Trim();
            string contrasena = Contrasena_1.Text.Trim();
            Session["Correo"] = correo;

            try
            {
                // Validar que los campos no estén vacíos
                if (string.IsNullOrEmpty(correo) || string.IsNullOrEmpty(contrasena))
                {
                    Response.Write("<script>alert('Correo o contraseña no pueden estar vacíos.');</script>");
                    return;
                }

                using (SqlConnection connection = Conexion.GetOpenConnection())
                {
                    if (connection.State != System.Data.ConnectionState.Open)
                    {
                        Response.Write("<script>alert('No se pudo establecer conexión con la base de datos.');</script>");
                        return;
                    }

                    // Verificar arrendador
                    string queryArrendador = "SELECT Codigo FROM RegistroArrendador WHERE DireccionCorreo = @Correo AND Contrasenia = @Contraseña";
                    SqlParameter[] parametersArrendador = {
                        new SqlParameter("@Correo", correo),
                        new SqlParameter("@Contraseña", contrasena)
                    };

                    object codigoArrendador = Conexion.ExecuteScalar(queryArrendador, parametersArrendador);
                    if (codigoArrendador != null)
                    {
                        if (codigoArrendador == DBNull.Value)
                        {
                            // Si el código es NULL, el correo está verificado
                            Response.Write("<script>alert('Inicio de sesión exitoso como arrendador.');</script>");
                            Response.Redirect("~/Pagina_Maestra/Menu_Arrendador_Principal.aspx");
                            return;
                        }
                        else
                        {
                            // Si el código no es NULL, el correo no está verificado
                            Response.Write("<script>alert('El arrendador no ha verificado su correo. Por favor, complete la verificación.');</script>");
                            return;
                        }
                    }

                    // Verificar usuario (alumno)
                    string queryUsuario = "SELECT Codigo FROM Usuario WHERE Correo = @Correo AND Contraseña = @Contraseña";
                    SqlParameter[] parametersUsuario = {
                        new SqlParameter("@Correo", correo),
                        new SqlParameter("@Contraseña", contrasena)
                    };

                    object codigoUsuario = Conexion.ExecuteScalar(queryUsuario, parametersUsuario);
                    if (codigoUsuario != null)
                    {
                        if (codigoUsuario == DBNull.Value)
                        {
                            // Si el código es NULL, el correo está verificado
                            Response.Write("<script>alert('Inicio de sesión exitoso como alumno.');</script>");
                            Response.Redirect("~/Pagina_Maestra/Pagina_Menu_usuario.aspx");
                            return;
                        }
                        else
                        {
                            // Si el código no es NULL, el correo no está verificado
                            Response.Write("<script>alert('El usuario no ha verificado su correo. Por favor, complete la verificación.');</script>");
                            return;
                        }
                    }

                    // Si las credenciales no coinciden con ninguna tabla
                    Response.Write("<script>alert('Correo o contraseña incorrectos.');</script>");
                }
            }
            catch (Exception ex)
            {
                // Manejar errores generales
                Response.Write("<script>alert('Ha ocurrido un error: " + ex.Message + "');</script>");
                Console.WriteLine("Error al iniciar sesión: " + ex.Message);
            }
        }
    }
}
