using System;
using System.Data.SqlClient;

namespace EjemploHerenciaPaginasWeb.Helpers
{
    public class Conexion
    {
        private static readonly string connectionString = "Server=Jose-Sauza;Database=MiBaseDeDatos;Trusted_Connection=True;";

        // Método para obtener una conexión SQL abierta
        public static SqlConnection GetOpenConnection()
        {
            SqlConnection connection = new SqlConnection(connectionString);
            try
            {
                connection.Open();
                return connection;
            }
            catch (Exception ex)
            {
                // Manejar la excepción según sea necesario
                throw new Exception("Error al conectar a la base de datos: " + ex.Message);
            }
        }

        // Método para ejecutar consultas SQL (Ejemplo: INSERT, UPDATE, DELETE)
        public static int ExecuteNonQuery(string query, SqlParameter[] parameters = null)
        {
            using (SqlConnection connection = GetOpenConnection())
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    if (parameters != null)
                    {
                        command.Parameters.AddRange(parameters);
                    }

                    return command.ExecuteNonQuery(); // Devuelve el número de filas afectadas
                }
            }
        }
        // Método ExecuteScalar
        public static object ExecuteScalar(string query, SqlParameter[] parameters)
        {
            using (SqlConnection connection = GetOpenConnection())
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    if (parameters != null)
                    {
                        command.Parameters.AddRange(parameters); // Agregar los parámetros
                    }

                    // Ejecutar y devolver el valor escalar
                    return command.ExecuteScalar();
                }
            }
        }
    }
}
