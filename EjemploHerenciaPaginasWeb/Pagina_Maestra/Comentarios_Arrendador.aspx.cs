using EjemploHerenciaPaginasWeb.Helpers;
using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EjemploHerenciaPaginasWeb.Pagina_Maestra
{
    public partial class Comentarios_Arrendador : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarComentarios(); // Carga los comentarios al iniciar la página
            }
        }

        public void CargarComentarios()
        {
            // Consulta para mostrar solo los comentarios cuya publicación existe y VerificacionID es NULL
            string query = @"
                SELECT C.ID, C.Usuario, C.Fecha, C.VerificacionID 
                FROM Comentarios C
                INNER JOIN Departamento D ON C.DepartamentoID = D.ID
                WHERE D.ID IS NOT NULL AND C.VerificacionID IS NULL";

            DataTable comentariosTable = new DataTable();

            try
            {
                using (SqlConnection connection = Conexion.GetOpenConnection())
                {
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        using (SqlDataAdapter adapter = new SqlDataAdapter(command))
                        {
                            adapter.Fill(comentariosTable);
                        }
                    }
                }

                // Vincula los datos al GridView
                if (comentariosTable.Rows.Count > 0)
                {
                    gridComentarios.DataSource = comentariosTable;
                    gridComentarios.DataBind();
                }
                else
                {
                    lblMensaje.Text = "No se encontraron comentarios pendientes de verificación para publicaciones existentes.";
                    lblMensaje.Visible = true;
                }
            }
            catch (Exception ex)
            {
                lblMensaje.Text = "Error al cargar los comentarios: " + ex.Message;
                lblMensaje.Visible = true;
            }
        }

        protected void gridComentarios_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Aprobar")
            {
                int comentarioId = Convert.ToInt32(e.CommandArgument);
                if (ActualizarVerificacion(comentarioId, 1)) // Verificación aprobada
                {
                    MostrarAlerta("Comentario aprobado.");
                }
            }
            else if (e.CommandName == "Rechazar")
            {
                int comentarioId = Convert.ToInt32(e.CommandArgument);
                if (ActualizarVerificacion(comentarioId, 0)) // Verificación rechazada
                {
                    MostrarAlerta("Comentario no aprobado.");
                }
            }
        }

        private bool ActualizarVerificacion(int comentarioId, int verificacion)
        {
            string query = "UPDATE Comentarios SET VerificacionID = @VerificacionID WHERE ID = @ComentarioID";

            try
            {
                using (SqlConnection connection = Conexion.GetOpenConnection())
                {
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@VerificacionID", verificacion);
                        command.Parameters.AddWithValue("@ComentarioID", comentarioId);

                        command.ExecuteNonQuery();
                    }
                }

                // Recarga los comentarios después de actualizar para reflejar los cambios
                CargarComentarios();
                return true;
            }
            catch (Exception ex)
            {
                lblMensaje.Text = $"Error al actualizar la verificación para el ID {comentarioId}: {ex.Message}";
                lblMensaje.Visible = true;
                return false;
            }
        }

        private void MostrarAlerta(string mensaje)
        {
            // Script para mostrar una alerta en el navegador
            string script = $"alert('{mensaje}');";
            ScriptManager.RegisterStartupScript(this, GetType(), "Alerta", script, true);
        }
    }
}
