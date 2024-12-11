using EjemploHerenciaPaginasWeb.Helpers;
using System;
using System.Data.SqlClient;
using System.IO;
using System.Web;
using System.Web.UI;

namespace EjemploHerenciaPaginasWeb.Pagina_Maestra
{
    public partial class Menu_Arrendador_Publicar_Inmueble1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["DepartamentoID"] != null)
                {
                    int departamentoID = Convert.ToInt32(Session["DepartamentoID"]);
                    lblDepartamentoID.Text = "ID del Departamento: " + departamentoID.ToString();
                }
                else
                {
                    lblDepartamentoID.Text = "No se ha creado un departamento en la sesión actual.";
                }
            }
        }

        protected void btnSubir_Click(object sender, EventArgs e)
        {
            if (fileUpload1.HasFiles)
            {
                string correoArrendador = Session["Correo"]?.ToString();
                if (string.IsNullOrEmpty(correoArrendador))
                {
                    lblMensaje.Text = "No se pudo identificar al arrendador. Por favor, inicia sesión.";
                    lblMensaje.Visible = true;
                    return;
                }

                try
                {
                    // Paso 1: Obtener o Crear el Departamento
                    int departamentoID = 0;

                    if (Session["DepartamentoID"] == null)
                    {
                        departamentoID = CrearNuevoDepartamento(correoArrendador);
                        if (departamentoID == 0)
                        {
                            lblMensaje.Text = "Error al crear el departamento. Por favor, inténtelo nuevamente.";
                            lblMensaje.Visible = true;
                            return;
                        }

                        // Asignar el nuevo ID a la sesión
                        Session["DepartamentoID"] = departamentoID;
                    }
                    else
                    {
                        departamentoID = Convert.ToInt32(Session["DepartamentoID"]);
                    }

                    // Paso 2: Subir las Imágenes
                    int contador = 0;

                    foreach (HttpPostedFile file in fileUpload1.PostedFiles)
                    {
                        if (contador >= 10)
                        {
                            lblMensaje.Text = "Solo puedes subir un máximo de 10 imágenes.";
                            lblMensaje.Visible = true;
                            return;
                        }

                        string extension = Path.GetExtension(file.FileName).ToLower();
                        if (extension == ".jpg" || extension == ".jpeg" || extension == ".png" || extension == ".gif")
                        {
                            byte[] imagenBytes;
                            using (BinaryReader br = new BinaryReader(file.InputStream))
                            {
                                imagenBytes = br.ReadBytes(file.ContentLength);
                            }

                            // Guardar la imagen asociada al DepartamentoID correcto
                            string queryImagen = "INSERT INTO Imagenes (DepartamentoID, NombreArchivo, Imagen) VALUES (@DepartamentoID, @NombreArchivo, @Imagen)";
                            using (SqlConnection connection = Conexion.GetOpenConnection())
                            {
                                SqlCommand cmd = new SqlCommand(queryImagen, connection);
                                cmd.Parameters.AddWithValue("@DepartamentoID", departamentoID);
                                cmd.Parameters.AddWithValue("@NombreArchivo", file.FileName);
                                cmd.Parameters.AddWithValue("@Imagen", imagenBytes);

                                cmd.ExecuteNonQuery();
                            }

                            contador++;
                        }
                        else
                        {
                            lblMensaje.Text = "Solo se permiten imágenes en formatos .jpg, .jpeg, .png o .gif.";
                            lblMensaje.Visible = true;
                            return;
                        }
                    }

                    // Redirigir a la siguiente página después de subir las imágenes
                    lblMensaje.Text = $"Se han subido correctamente {contador} imagen(es) al departamento con ID {departamentoID}.";
                    lblMensaje.Visible = true;

                    Response.Redirect("~/Pagina_Maestra/Menu_Arrendador_Principal.aspx");
                }
                catch (Exception ex)
                {
                    lblMensaje.Text = $"Error: {ex.Message}";
                    lblMensaje.Visible = true;
                }
            }
            else
            {
                lblMensaje.Text = "Por favor, selecciona al menos una imagen para subir.";
                lblMensaje.Visible = true;
            }
        }

        /// <summary>
        /// Crea un nuevo departamento asociado al correo del arrendador y devuelve su ID.
        /// </summary>
        /// <param name="correoArrendador">Correo del arrendador</param>
        /// <returns>ID del departamento recién creado</returns>
        private int CrearNuevoDepartamento(string correoArrendador)
        {
            int departamentoID = 0;

            string queryInsert = @"INSERT INTO Departamento (DireccionCorreo, Calle, Colonia, Ciudad, Municipio, NumeroRecamaras) 
                                   OUTPUT INSERTED.ID 
                                   VALUES (@Correo, @Calle, @Colonia, @Ciudad, @Municipio, @NumeroRecamaras)";
            using (SqlConnection connection = Conexion.GetOpenConnection())
            {
                SqlCommand cmd = new SqlCommand(queryInsert, connection);

                // Datos predeterminados para el nuevo departamento
                cmd.Parameters.AddWithValue("@Correo", correoArrendador);
                cmd.Parameters.AddWithValue("@Calle", "Calle Desconocida");
                cmd.Parameters.AddWithValue("@Colonia", "Colonia Desconocida");
                cmd.Parameters.AddWithValue("@Ciudad", "Ciudad Desconocida");
                cmd.Parameters.AddWithValue("@Municipio", "Municipio Desconocido");
                cmd.Parameters.AddWithValue("@NumeroRecamaras", 1);

                // Obtener el ID del departamento recién creado
                object result = cmd.ExecuteScalar();
                if (result != null)
                {
                    departamentoID = Convert.ToInt32(result);
                }
            }

            return departamentoID;
        }
    }
}
