using System;

namespace EjemploHerenciaPaginasWeb
{
    public partial class Default : System.Web.UI.Page
    {

        public void RegistroAlumno()
        {
            Response.Redirect("~/Pagina_Maestra/Pagina_Registro_Alumno.aspx");
        }
        public void RegistroArrendador()
        {
            Response.Redirect("~/Pagina_Maestra/Pagina_Registro_Arrendador.aspx");
        }
        public void InicioSesion()
        {
            Response.Redirect("~/Pagina_Maestra/Inicio_Sesion.aspx");
        }
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnAlumno_Click(object sender, EventArgs e)
        {
            RegistroAlumno();
        }
        protected void btnArrendador_Click(object sender, EventArgs e)
        {
            RegistroArrendador();
        }

        protected void btnInicioSesion_Click(object sender, EventArgs e)
        {
            InicioSesion();
        }
    }
}
