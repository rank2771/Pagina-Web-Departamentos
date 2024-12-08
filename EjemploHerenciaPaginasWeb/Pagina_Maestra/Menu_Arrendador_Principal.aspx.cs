using EjemploHerenciaPaginasWeb.Helpers;
using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace EjemploHerenciaPaginasWeb
{
    public partial class MenuArrendador : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["Correo"] != null)
                {
                    string correo = Session["Correo"].ToString();
                    lblCorreo.Text = correo; // Mostrar el correo en un Label
                    CargarDepartamentosPorCorreo(correo);
                }
                else
                {
                    Response.Redirect("~/InicioSesion.aspx");
                }
            }
        }

        public void CargarDepartamentosPorCorreo(string correo)
        {
            try
            {
                string query = @"
                SELECT 
                    D.ID AS DepartamentoID,
                    D.Precio,
                    D.InformacionBreve,
                    D.Calle,
                    D.Colonia,
                    D.Ciudad,
                    D.Municipio,
                    D.NumeroRecamaras,
                    D.NumeroBanos,
                    ISNULL(I.Imagen, NULL) AS FotoDepartamento
                FROM 
                    Departamento D
                LEFT JOIN 
                    (SELECT DepartamentoID, Imagen, 
                            ROW_NUMBER() OVER (PARTITION BY DepartamentoID ORDER BY FechaSubida) AS OrdenImagen
                     FROM Imagenes) I 
                ON D.ID = I.DepartamentoID AND I.OrdenImagen = 1
                WHERE LTRIM(RTRIM(D.DireccionCorreo)) = @Correo";

                using (SqlConnection connection = Conexion.GetOpenConnection())
                {
                    SqlCommand command = new SqlCommand(query, connection);
                    command.Parameters.AddWithValue("@Correo", correo);

                    SqlDataAdapter adapter = new SqlDataAdapter(command);
                    DataTable dt = new DataTable();
                    adapter.Fill(dt);

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
                            row["FotoBase64"] = "~/Images/default-image.png";
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

        protected void RepeaterDepartamentos_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Eliminar")
            {
                try
                {
                    if (int.TryParse(e.CommandArgument.ToString(), out int departamentoID))
                    {
                        using (SqlConnection connection = Conexion.GetOpenConnection())
                        {
                            string deleteQuery = "DELETE FROM Departamento WHERE ID = @DepartamentoID";
                            using (SqlCommand cmd = new SqlCommand(deleteQuery, connection))
                            {
                                cmd.Parameters.AddWithValue("@DepartamentoID", departamentoID);
                                cmd.ExecuteNonQuery();
                            }
                        }

                        string correo = Session["Correo"]?.ToString();
                        if (!string.IsNullOrEmpty(correo))
                        {
                            CargarDepartamentosPorCorreo(correo);
                        }

                        Response.Write("<script>alert('Departamento eliminado con éxito.');</script>");
                    }
                }
                catch (Exception ex)
                {
                    Response.Write("<script>alert('Error al eliminar el departamento: " + ex.Message + "');</script>");
                }
            }
        }

        protected void BtnAgregarDepartamento_Click(object sender, EventArgs e)
        {
            string correo = Session["Correo"]?.ToString();
            if (!string.IsNullOrEmpty(correo))
            {
                Session["Correo"] = correo;
                Response.Redirect("~/Pagina_Maestra/Menu_Arrendador_Publicar_Inmueble_Direccion.aspx");
            }
        }

        protected void Comentarios_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Pagina_Maestra/Comentarios_Arrendador.aspx");
        }
    }
}
