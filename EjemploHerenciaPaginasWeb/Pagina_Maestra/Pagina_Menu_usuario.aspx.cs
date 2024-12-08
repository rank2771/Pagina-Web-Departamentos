using EjemploHerenciaPaginasWeb.Helpers;
using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace EjemploHerenciaPaginasWeb.Pagina_Maestra
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarTodosLosDepartamentos();
            }
        }

        public void CargarTodosLosDepartamentos()
        {
            try
            {
                // Consulta SQL para obtener todos los departamentos y la primera imagen asociada
                string query = @"
                WITH ImagenesPorDepartamento AS (
                    SELECT 
                        DepartamentoID,
                        Imagen,
                        ROW_NUMBER() OVER (PARTITION BY DepartamentoID ORDER BY FechaSubida) AS OrdenImagen
                    FROM Imagenes
                )
                SELECT 
                    D.ID AS DepartamentoID,
                    D.Precio,
                    D.InformacionBreve,
                    ISNULL(I.Imagen, NULL) AS FotoDepartamento
                FROM 
                    Departamento D
                LEFT JOIN 
                    ImagenesPorDepartamento I 
                ON 
                    D.ID = I.DepartamentoID AND I.OrdenImagen = 1;";

                using (SqlConnection connection = Conexion.GetOpenConnection())
                {
                    SqlCommand command = new SqlCommand(query, connection);
                    SqlDataAdapter adapter = new SqlDataAdapter(command);
                    DataTable dt = new DataTable();
                    adapter.Fill(dt);

                    // Agregar una columna adicional para las imágenes en formato Base64
                    dt.Columns.Add("FotoBase64", typeof(string));

                    foreach (DataRow row in dt.Rows)
                    {
                        if (row["FotoDepartamento"] != DBNull.Value && row["FotoDepartamento"] is byte[])
                        {
                            byte[] imagenBytes = (byte[])row["FotoDepartamento"];
                            string imagenBase64 = "data:image/png;base64," + Convert.ToBase64String(imagenBytes);
                            row["FotoBase64"] = imagenBase64;
                        }
                        else
                        {
                            row["FotoBase64"] = "~/Images/default-image.png"; // Imagen predeterminada si no hay foto
                        }
                    }

                    RepeaterDepartamentos.DataSource = dt;
                    RepeaterDepartamentos.DataBind();
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error al cargar los departamentos: " + ex.Message + "');</script>");
            }
        }

        protected void RepeaterDepartamentos_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "VerDetalles")
            {
                try
                {
                    // Capturar el ID del departamento desde CommandArgument
                    int departamentoId = Convert.ToInt32(e.CommandArgument);

                    // Almacenar el ID en una variable de sesión
                    Session["DepartamentoID"] = departamentoId;

                    // Comprobar si el correo está disponible en la sesión
                    if (Session["Correo"] == null)
                    {
                        Response.Write("<script>alert('No se encontró el correo en la sesión.');</script>");
                        return;
                    }

                    // Obtener el correo desde la sesión
                    string correo = Session["Correo"].ToString();
                    // Redirigir a la página de detalles
                    Response.Redirect("Pagina_Menu_usuario_Clic.aspx");
                }
                catch (Exception ex)
                {
                    // Manejo de errores
                    Response.Write("<script>alert('Error al redirigir a la página de detalles: " + ex.Message + "');</script>");
                }
            }
        }
    }
}
