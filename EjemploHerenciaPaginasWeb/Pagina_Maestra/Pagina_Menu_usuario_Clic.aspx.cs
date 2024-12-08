using EjemploHerenciaPaginasWeb.Helpers;
using System;
using System.Data.SqlClient;
using System.Data;

namespace EjemploHerenciaPaginasWeb.Pagina_Maestra
{
    public partial class Pagina_Menu_usuario_Clic : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Verificar si las variables de sesión existen
                if (Session["DepartamentoID"] != null)
                {
                    int departamentoId = Convert.ToInt32(Session["DepartamentoID"]);

                    // Verificar el valor de la variable de sesión "Correo"
                    string correo = Session["Correo"] != null ? Session["Correo"].ToString() : "Correo no disponible";

                    // Cargar los datos del departamento
                    CargarDetallesDepartamento(departamentoId);
                    CargarImagenesDepartamento(departamentoId);
                    CargarComentarios(departamentoId); // Cargar comentarios aprobados
                }
                else
                {
                    // Si no existe la variable de sesión, redirigir a otra página
                    Response.Redirect("Pagina_Menu_usuario.aspx");
                }
            }
        }

        private void CargarDetallesDepartamento(int departamentoId)
        {
            try
            {
                string query = @"
        SELECT 
            D.Precio, 
            CONCAT(D.Calle, ', ', D.Colonia, ', ', D.Ciudad, ', ', D.Municipio) AS Ubicacion,
            D.NumeroRecamaras, 
            C.Nombre AS NombreContacto, 
            C.NumeroTelefono AS Telefono, 
            C.DireccionCorreo AS Correo,
            D.Estacionamiento,
            D.Mascotas,
            D.Amueblado
        FROM 
            Departamento D
        INNER JOIN 
            RegistroArrendador C 
        ON 
            D.DireccionCorreo = C.DireccionCorreo
        WHERE 
            D.ID = @DepartamentoID";

                using (SqlConnection connection = Conexion.GetOpenConnection())
                {
                    SqlCommand command = new SqlCommand(query, connection);
                    command.Parameters.AddWithValue("@DepartamentoID", departamentoId);

                    SqlDataReader reader = command.ExecuteReader();
                    if (reader.Read())
                    {
                        // Asignar valores a los controles existentes
                        lblPrecio.Text = reader["Precio"] != DBNull.Value ? reader["Precio"].ToString() : "No disponible";
                        lblUbicacion.Text = reader["Ubicacion"] != DBNull.Value ? reader["Ubicacion"].ToString() : "No disponible";
                        lblHabitaciones.Text = reader["NumeroRecamaras"] != DBNull.Value ? reader["NumeroRecamaras"].ToString() : "No disponible";
                        lblNombreContacto.Text = reader["NombreContacto"] != DBNull.Value ? reader["NombreContacto"].ToString() : "No disponible";
                        lblTelefono.Text = reader["Telefono"] != DBNull.Value ? reader["Telefono"].ToString() : "No disponible";
                        lblCorreoContacto.Text = reader["Correo"] != DBNull.Value ? reader["Correo"].ToString() : "No disponible";

                        // Asignar valores a los controles para Normas (manejo de DBNull)
                        lblEstacionamiento.Text = reader["Estacionamiento"] != DBNull.Value && Convert.ToBoolean(reader["Estacionamiento"]) ? "Sí" : "No";
                        lblMascotas.Text = reader["Mascotas"] != DBNull.Value && Convert.ToBoolean(reader["Mascotas"]) ? "Sí" : "No";
                        lblAmueblado.Text = reader["Amueblado"] != DBNull.Value && Convert.ToBoolean(reader["Amueblado"]) ? "Sí" : "No";
                    }
                    reader.Close();
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error al cargar los detalles: " + ex.Message + "');</script>");
            }
        }


        private void CargarImagenesDepartamento(int departamentoId)
        {
            try
            {
                string query = @"SELECT Imagen FROM Imagenes WHERE DepartamentoID = @DepartamentoID";

                using (SqlConnection connection = Conexion.GetOpenConnection())
                {
                    SqlCommand command = new SqlCommand(query, connection);
                    command.Parameters.AddWithValue("@DepartamentoID", departamentoId);

                    SqlDataAdapter adapter = new SqlDataAdapter(command);
                    DataTable dt = new DataTable();
                    adapter.Fill(dt);

                    dt.Columns.Add("ImagenBase64", typeof(string));
                    foreach (DataRow row in dt.Rows)
                    {
                        if (row["Imagen"] != DBNull.Value)
                        {
                            byte[] imagenBytes = (byte[])row["Imagen"];
                            string imagenBase64 = "data:image/png;base64," + Convert.ToBase64String(imagenBytes);
                            row["ImagenBase64"] = imagenBase64;
                        }
                    }

                    RepeaterImagenes.DataSource = dt;
                    RepeaterImagenes.DataBind();
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error al cargar las imágenes: " + ex.Message + "');</script>");
            }
        }

        protected void btnEnviarComentario_Click(object sender, EventArgs e)
        {
            // Código para guardar el comentario
            string comentario = txtComentario.Text;

            if (Session["DepartamentoID"] != null && Session["Correo"] != null)
            {
                int departamentoId = Convert.ToInt32(Session["DepartamentoID"]);
                string correo = Session["Correo"].ToString();

                try
                {
                    // Consulta SQL para insertar en la tabla Comentarios
                    string query = @"
                INSERT INTO Comentarios (DepartamentoID, Usuario, Comentario, Fecha) 
                VALUES (@DepartamentoID, @Usuario, @Comentario, @Fecha)";

                    using (SqlConnection connection = Conexion.GetOpenConnection())
                    {
                        SqlCommand command = new SqlCommand(query, connection);
                        command.Parameters.AddWithValue("@DepartamentoID", departamentoId);
                        command.Parameters.AddWithValue("@Usuario", correo);
                        command.Parameters.AddWithValue("@Comentario", comentario);
                        command.Parameters.AddWithValue("@Fecha", DateTime.Now);

                        command.ExecuteNonQuery();
                    }
                    Response.Write("<script>alert('Esperando Confirmacion del arrendador');</script>");
                    // Limpiar el campo de texto del comentario
                    txtComentario.Text = "";

                    // Recargar los comentarios después de insertar el nuevo
                    CargarComentarios(departamentoId);
                }
                catch (Exception ex)
                {
                    // Manejar errores y mostrar un mensaje
                    Response.Write("<script>alert('Error al enviar el comentario: " + ex.Message + "');</script>");
                }
            }
            else
            {
                // Mostrar un mensaje si falta el DepartamentoID o Correo
                Response.Write("<script>alert('Departamento o correo no identificado.');</script>");
            }
        }

        private void CargarComentarios(int departamentoId)
        {
            try
            {
                string query = @"
                SELECT Usuario, Comentario, Fecha 
                FROM Comentarios 
                WHERE DepartamentoID = @DepartamentoID AND VerificacionID = 1";

                using (SqlConnection connection = Conexion.GetOpenConnection())
                {
                    SqlCommand command = new SqlCommand(query, connection);
                    command.Parameters.AddWithValue("@DepartamentoID", departamentoId);

                    SqlDataAdapter adapter = new SqlDataAdapter(command);
                    DataTable dt = new DataTable();
                    adapter.Fill(dt);

                    RepeaterComentarios.DataSource = dt;
                    RepeaterComentarios.DataBind();
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error al cargar los comentarios: " + ex.Message + "');</script>");
            }
        }
    }
}
