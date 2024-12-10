using EjemploHerenciaPaginasWeb.Helpers;
using System;
using System.Data.SqlClient;
using System.Web.UI;

namespace EjemploHerenciaPaginasWeb.Pagina_Maestra
{
    public partial class Menu_Arrendador_Publicar_Inmueble_Direccion : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["Correo"] != null)
                {
                    string correo = Session["Correo"].ToString();

                    // Siempre reiniciar DepartamentoID para un nuevo registro
                    Session["DepartamentoID"] = null;

                    try
                    {
                        using (SqlConnection connection = Conexion.GetOpenConnection())
                        {
                            // Crear un nuevo departamento y obtener el ID generado
                            string query = @"INSERT INTO Departamento (DireccionCorreo) 
                                     VALUES (@Correo);
                                     SELECT SCOPE_IDENTITY();";

                            using (SqlCommand cmd = new SqlCommand(query, connection))
                            {
                                cmd.Parameters.AddWithValue("@Correo", correo);

                                // Obtener el ID del departamento recién creado
                                object result = cmd.ExecuteScalar();
                                if (result != null)
                                {
                                    int departamentoID = Convert.ToInt32(result);
                                    Session["DepartamentoID"] = departamentoID; // Guardar el ID en la sesión

                                    Response.Write("<script>alert('Nuevo departamento creado con ID: " + departamentoID + "');</script>");
                                }
                                else
                                {
                                    Response.Write("<script>alert('Error al crear un nuevo departamento. Redirigiendo al menú principal.');</script>");
                                    Response.Redirect("~/Pagina_Maestra/Menu_Arrendador.aspx");
                                }
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        Response.Write("<script>alert('Error al crear un nuevo departamento: " + ex.Message.Replace("'", "\\'") + "');</script>");
                    }
                }
                else
                {
                    // Si no hay correo en la sesión, redirigir al menú principal
                    Response.Write("<script>alert('No se encontró el correo en la sesión. Redirigiendo al menú principal.');</script>");
                    Response.Redirect("~/Pagina_Maestra/Menu_Arrendador.aspx");
                }
            }
        }


        protected void BtnConfirmarDireccion_Click(object sender, EventArgs e)
        {
            // Validar si existe la variable de sesión DepartamentoID
            if (Session["DepartamentoID"] != null)
            {
                int departamentoID = Convert.ToInt32(Session["DepartamentoID"]);
                string calle = txtCalle.Text.Trim();
                string colonia = txtColonia.Text.Trim();
                string ciudad = txtCiudad.Text.Trim();
                string municipio = txtMunicipio.Text.Trim();

                // Validar que todos los campos de la dirección no estén vacíos
                if (string.IsNullOrWhiteSpace(calle) || string.IsNullOrWhiteSpace(colonia) ||
                    string.IsNullOrWhiteSpace(ciudad) || string.IsNullOrWhiteSpace(municipio))
                {
                    Response.Write("<script>alert('Todos los campos de la dirección son obligatorios.');</script>");
                    return;
                }

                try
                {
                    // Actualizar la dirección del departamento
                    string query = @"UPDATE Departamento
                                     SET Calle = @Calle, Colonia = @Colonia, Ciudad = @Ciudad, Municipio = @Municipio
                                     WHERE ID = @DepartamentoID";

                    using (SqlConnection connection = Conexion.GetOpenConnection())
                    {
                        using (SqlCommand cmd = new SqlCommand(query, connection))
                        {
                            cmd.Parameters.AddWithValue("@Calle", calle);
                            cmd.Parameters.AddWithValue("@Colonia", colonia);
                            cmd.Parameters.AddWithValue("@Ciudad", ciudad);
                            cmd.Parameters.AddWithValue("@Municipio", municipio);
                            cmd.Parameters.AddWithValue("@DepartamentoID", departamentoID);

                            int filasAfectadas = cmd.ExecuteNonQuery();
                            if (filasAfectadas > 0)
                            {
                                Response.Write("<script>alert('Dirección guardada correctamente.');</script>");

                                // Redirigir a la siguiente página
                                Response.Redirect("~/Pagina_Maestra/Menu_Arrendador_Publicar_Caracteristicas.aspx");
                            }
                            else
                            {
                                Response.Write("<script>alert('No se pudo actualizar la dirección. Por favor, intente de nuevo.');</script>");
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    Response.Write("<script>alert('Error al guardar la dirección: " + ex.Message.Replace("'", "\\'") + "');</script>");
                }
            }
            else
            {
                // Si no hay DepartamentoID en la sesión
                Response.Write("<script>alert('No se encontró el ID del departamento en la sesión. Redirigiendo al menú principal.');</script>");
                Response.Redirect("~/Pagina_Maestra/Menu_Arrendador.aspx");
            }
        }
    }
}
