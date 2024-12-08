using EjemploHerenciaPaginasWeb.Helpers;
using System;
using System.Data.SqlClient;
using System.IO;
using System.Linq;

namespace EjemploHerenciaPaginasWeb.Pagina_Maestra
{
    public partial class Agregar : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnAgregar_Click(object sender, EventArgs e)
        {
                if (Session["Correo"] != null)
                {
                    string correo = Session["Correo"].ToString();
                    lblCorreo.Text = correo; // Muestra el correo en un Label, por ejemplo
                }
            bool isValid = true;

            // Validaciones de los campos
            if (!fileFotoDepartamento.HasFile)
            {
                lblErrorFoto.Text = "La foto del departamento es obligatoria.";
                lblErrorFoto.Visible = true;
                isValid = false;
            }
            else
            {
                lblErrorFoto.Visible = false;

                // Validar el tipo de archivo (por ejemplo, solo imágenes)
                string fileExtension = Path.GetExtension(fileFotoDepartamento.FileName).ToLower();
                string[] allowedExtensions = { ".jpg", ".jpeg", ".png", ".gif" };

                if (!allowedExtensions.Contains(fileExtension))
                {
                    lblErrorFoto.Text = "Solo se permiten archivos de imagen (.jpg, .jpeg, .png, .gif).";
                    lblErrorFoto.Visible = true;
                    isValid = false;
                }
                else
                {
                    lblErrorFoto.Visible = false;
                }
            }

            if (!decimal.TryParse(txtPrecio.Text, out _))
            {
                lblErrorPrecio.Text = "El precio debe ser un número válido.";
                lblErrorPrecio.Visible = true;
                txtPrecio.CssClass += " error";
                isValid = false;
            }
            else
            {
                lblErrorPrecio.Visible = false;
                txtPrecio.CssClass = txtPrecio.CssClass.Replace(" error", "");
            }

            if (string.IsNullOrWhiteSpace(txtInformacionBreve.Text))
            {
                lblErrorInfoBreve.Text = "La información breve es obligatoria.";
                lblErrorInfoBreve.Visible = true;
                txtInformacionBreve.CssClass += " error";
                isValid = false;
            }
            else
            {
                lblErrorInfoBreve.Visible = false;
                txtInformacionBreve.CssClass = txtInformacionBreve.CssClass.Replace(" error", "");
            }

            if (string.IsNullOrWhiteSpace(txtCalle.Text))
            {
                lblErrorCalle.Text = "La calle es obligatoria.";
                lblErrorCalle.Visible = true;
                txtCalle.CssClass += " error";
                isValid = false;
            }
            else
            {
                lblErrorCalle.Visible = false;
                txtCalle.CssClass = txtCalle.CssClass.Replace(" error", "");
            }

            if (string.IsNullOrWhiteSpace(txtColonia.Text))
            {
                lblErrorColonia.Text = "La colonia es obligatoria.";
                lblErrorColonia.Visible = true;
                txtColonia.CssClass += " error";
                isValid = false;
            }
            else
            {
                lblErrorColonia.Visible = false;
                txtColonia.CssClass = txtColonia.CssClass.Replace(" error", "");
            }

            if (!int.TryParse(txtNumeroRecamaras.Text, out _))
            {
                lblErrorRecamaras.Text = "El número de recámaras debe ser un número.";
                lblErrorRecamaras.Visible = true;
                txtNumeroRecamaras.CssClass += " error";
                isValid = false;
            }
            else
            {
                lblErrorRecamaras.Visible = false;
                txtNumeroRecamaras.CssClass = txtNumeroRecamaras.CssClass.Replace(" error", "");
            }

            if (!int.TryParse(txtNumeroBanos.Text, out _))
            {
                lblErrorBanos.Text = "El número de baños debe ser un número.";
                lblErrorBanos.Visible = true;
                txtNumeroBanos.CssClass += " error";
                isValid = false;
            }
            else
            {
                lblErrorBanos.Visible = false;
                txtNumeroBanos.CssClass = txtNumeroBanos.CssClass.Replace(" error", "");
            }

            // Si las validaciones son correctas, ejecutar la lógica de inserción
            if (isValid)
            {
                try
                {
                    // Leer la imagen como arreglo de bytes
                    byte[] imagenBytes;
                    using (BinaryReader binaryReader = new BinaryReader(fileFotoDepartamento.PostedFile.InputStream))
                    {
                        imagenBytes = binaryReader.ReadBytes(fileFotoDepartamento.PostedFile.ContentLength);
                    }

                    // Inserción en la tabla Departamento
                    string query = @"
                        INSERT INTO Departamento (
                            FotoDepartamento, Precio, InformacionBreve, Calle, Colonia, Ciudad, Municipio,
                            NumeroRecamaras, NumeroBanos, Estacionamiento, Mascotas, Amueblado,DireccionCorreo
                        )
                        VALUES (
                            @FotoDepartamento, @Precio, @InformacionBreve, @Calle, @Colonia, @Ciudad, @Municipio,
                            @NumeroRecamaras, @NumeroBanos, @Estacionamiento, @Mascotas, @Amueblado,@DireccionCorreo
                        );";

                    using (SqlConnection connection = Conexion.GetOpenConnection())
                    {
                        using (SqlCommand cmd = new SqlCommand(query, connection))
                        {
                            // Asignar los valores de los parámetros
                            cmd.Parameters.AddWithValue("@FotoDepartamento", imagenBytes);
                            cmd.Parameters.AddWithValue("@Precio", decimal.Parse(txtPrecio.Text));
                            cmd.Parameters.AddWithValue("@InformacionBreve", txtInformacionBreve.Text);
                            cmd.Parameters.AddWithValue("@Calle", txtCalle.Text);
                            cmd.Parameters.AddWithValue("@Colonia", txtColonia.Text);
                            cmd.Parameters.AddWithValue("@Ciudad", txtCiudad.Text);
                            cmd.Parameters.AddWithValue("@Municipio", txtMunicipio.Text);
                            cmd.Parameters.AddWithValue("@NumeroRecamaras", int.Parse(txtNumeroRecamaras.Text));
                            cmd.Parameters.AddWithValue("@NumeroBanos", int.Parse(txtNumeroBanos.Text));
                            cmd.Parameters.AddWithValue("@Estacionamiento", int.Parse(txtEstacionamiento.Text));
                            cmd.Parameters.AddWithValue("@Mascotas", int.Parse(txtMascotas.Text));
                            cmd.Parameters.AddWithValue("@Amueblado", int.Parse(txtAmueblado.Text));
                            cmd.Parameters.AddWithValue("@DireccionCorreo", lblCorreo.Text);

                            cmd.ExecuteNonQuery();
                        }
                    }

                    // Mostrar alerta de éxito
                    Response.Write("<script>alert('Departamento registrado exitosamente.');</script>");
                    Response.Redirect("~/Pagina_Maestra/Menu_Arrendador_Principal.aspx");
                }
                catch (Exception ex)
                {
                    // Mostrar alerta de error
                    Response.Write("<script>alert('Error al registrar el departamento: " + ex.Message + "');</script>");
                }
            }
        }
    }
}
