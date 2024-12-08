using EjemploHerenciaPaginasWeb.Helpers;
using System;
using System.Data.SqlClient;

namespace EjemploHerenciaPaginasWeb.Pagina_Maestra
{
    public partial class Menu_Arrendador_Publicar_Caracteristicas : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void BtnConfirmarCaracteristicas_Click(object sender, EventArgs e)
        {
            if (Session["DepartamentoID"] != null)
            {
                int departamentoID = Convert.ToInt32(Session["DepartamentoID"]);

                // Leer valores de los controles
                int numeroRecamaras = Convert.ToInt32(txtNumeroRecamaras.Text.Trim());
                int numeroBanos = Convert.ToInt32(txtNumeroBanos.Text.Trim());
                bool estacionamiento = txtEstacionamiento.Text.Trim() == "1";
                bool mascotas = txtMascotas.Text.Trim() == "1";
                bool amueblado = txtAmueblado.Text.Trim() == "1";
                string informacionBreve = txtInformacionBreve.Text.Trim();
                decimal precio = decimal.Parse(txtPrecio.Text.Trim());

                try
                {
                    // Consulta SQL para actualizar las características, descripción y precio
                    string query = @"UPDATE Departamento
                                     SET NumeroRecamaras = @NumeroRecamaras,
                                         NumeroBanos = @NumeroBanos,
                                         Estacionamiento = @Estacionamiento,
                                         Mascotas = @Mascotas,
                                         Amueblado = @Amueblado,
                                         InformacionBreve = @InformacionBreve,
                                         Precio = @Precio
                                     WHERE ID = @DepartamentoID";

                    // Ejecutar la consulta
                    using (SqlConnection connection = Conexion.GetOpenConnection())
                    {
                        using (SqlCommand cmd = new SqlCommand(query, connection))
                        {
                            // Asignar parámetros
                            cmd.Parameters.AddWithValue("@NumeroRecamaras", numeroRecamaras);
                            cmd.Parameters.AddWithValue("@NumeroBanos", numeroBanos);
                            cmd.Parameters.AddWithValue("@Estacionamiento", estacionamiento);
                            cmd.Parameters.AddWithValue("@Mascotas", mascotas);
                            cmd.Parameters.AddWithValue("@Amueblado", amueblado);
                            cmd.Parameters.AddWithValue("@InformacionBreve", informacionBreve);
                            cmd.Parameters.AddWithValue("@Precio", precio);
                            cmd.Parameters.AddWithValue("@DepartamentoID", departamentoID);

                            // Ejecutar la consulta
                            int filasAfectadas = cmd.ExecuteNonQuery();
                            if (filasAfectadas > 0)
                            {
                                Response.Write("<script>alert('Características, descripción y precio guardados correctamente.');</script>");
                                Response.Redirect("Menu_Arrendador_Principal.aspx"); // Redirigir a la página principal
                            }
                            else
                            {
                                Response.Write("<script>alert('No se pudo actualizar el departamento.');</script>");
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    Response.Write("<script>alert('Error: " + ex.Message.Replace("'", "\\'") + "');</script>");
                }
            }
            else
            {
                Response.Write("<script>alert('No se encontró el ID del departamento en la sesión.');</script>");
            }
        }
    }
}
