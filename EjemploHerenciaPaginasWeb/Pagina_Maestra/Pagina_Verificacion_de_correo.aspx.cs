using System;
using EjemploHerenciaPaginasWeb.Helpers;
using System.Data.SqlClient;

namespace EjemploHerenciaPaginasWeb
{
    public partial class Verificacion : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Aquí puedes agregar lógica de inicialización si es necesario.
            }
        }

        protected void Validar_Click(object sender, EventArgs e)
        {
            // Consultas SQL para obtener los códigos de verificación
            string queryUsuario = "SELECT TOP 1 Codigo, Id FROM Usuario WHERE Codigo IS NOT NULL ORDER BY Id DESC";
            string queryArrendador = "SELECT TOP 1 Codigo, IdArrendador FROM RegistroArrendador WHERE Codigo IS NOT NULL ORDER BY IdArrendador DESC";

            // Obtener el código ingresado desde los inputs del usuario
            string codigoIngresado = CodigoInput1.Value +
                                     CodigoInput2.Value +
                                     CodigoInput3.Value +
                                     CodigoInput4.Value +
                                     CodigoInput5.Value +
                                     CodigoInput6.Value;

            string script;

            try
            {
                using (SqlConnection connection = Conexion.GetOpenConnection())
                {
                    // Validar en la tabla Usuario
                    if (ValidarCodigo(connection, queryUsuario, codigoIngresado, "Usuario", "Id"))
                    {
                        script = "alert('¡El código ingresado coincide con el último generado en Usuario!');";
                        ClientScript.RegisterStartupScript(this.GetType(), "Alert", script, true);
                        Response.Redirect("~/Pagina_Maestra/Inicio_Sesion.aspx");
                        return;
                    }

                    // Validar en la tabla RegistroArrendador
                    if (ValidarCodigo(connection, queryArrendador, codigoIngresado, "RegistroArrendador", "IdArrendador"))
                    {
                        script = "alert('¡El código ingresado coincide con el último generado en RegistroArrendador!');";
                        ClientScript.RegisterStartupScript(this.GetType(), "Alert", script, true);
                        Response.Redirect("~/Pagina_Maestra/Inicio_Sesion.aspx");
                        return;
                    }

                    // Si no se encuentra en ninguna tabla
                    script = "alert('El código ingresado no coincide con ningún código en la base de datos.');";
                    ClientScript.RegisterStartupScript(this.GetType(), "Alert", script, true);
                }
            }
            catch (Exception ex)
            {
                // Manejar excepciones y mostrar mensaje al usuario
                script = $"alert('Error al consultar la base de datos: {ex.Message}');";
                ClientScript.RegisterStartupScript(this.GetType(), "Alert", script, true);
            }
        }

        private bool ValidarCodigo(SqlConnection connection, string query, string codigoIngresado, string tabla, string columnaId)
        {
            try
            {
                using (SqlCommand cmd = new SqlCommand(query, connection))
                {
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            string codigoBaseDatos = reader["Codigo"].ToString();
                            int id = Convert.ToInt32(reader[columnaId]);

                            if (codigoBaseDatos == codigoIngresado)
                            {
                                // Si el código coincide, eliminar el código de la base de datos
                                reader.Close(); // Cerrar el DataReader antes de realizar otra operación
                                EliminarCodigo(connection, tabla, columnaId, id);
                                return true;
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception($"Error al validar el código en la tabla {tabla}: {ex.Message}");
            }

            return false;
        }

        private void EliminarCodigo(SqlConnection connection, string tabla, string columnaId, int id)
        {
            string queryEliminar = $"UPDATE {tabla} SET Codigo = NULL WHERE {columnaId} = @Id";

            try
            {
                using (SqlCommand cmdEliminar = new SqlCommand(queryEliminar, connection))
                {
                    cmdEliminar.Parameters.AddWithValue("@Id", id);
                    cmdEliminar.ExecuteNonQuery();
                }
            }
            catch (Exception ex)
            {
                throw new Exception($"Error al eliminar el código en la tabla {tabla}: {ex.Message}");
            }
        }
    }
}
