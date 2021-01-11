using System;
using System.Collections.Generic;
using ProyectoCore_DAL.Conexion;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using ProyectoCore_Entidades;

namespace ProyectoCore_DAL.Manejadoras
{
    public class clsManejadoraPersonasDAL
    {
        /// <summary>
        /// Elimina una persona en la base de datos a partir de su ID
        /// </summary>
        /// <param name="IDPersona"></param>
        /// <returns></returns>
        public int eliminarPersonaDAL(int IDPersona)
        {
            clsMyConnection clsMyConnection = new clsMyConnection();
            SqlConnection sqlConnection = new SqlConnection();
            SqlCommand sqlCommand = new SqlCommand();

            int numeroFilasAfectadas = 0;

            sqlCommand.Parameters.Add("@IDPersona", System.Data.SqlDbType.Int).Value = IDPersona;
            sqlCommand.CommandText = "DELETE FROM Personas WHERE ID = @IDPersona";

            try
            {
                sqlConnection = clsMyConnection.getConnection();

                sqlCommand.Connection = sqlConnection;

                numeroFilasAfectadas = sqlCommand.ExecuteNonQuery();
            }
            catch (SqlException)
            {
                throw;
            }
            finally
            {
                clsMyConnection.closeConnection(ref sqlConnection);
            }


            return numeroFilasAfectadas;
        }

        /// <summary>
        /// Edita una persona en la base de datos a partir de un objeto persona
        /// </summary>
        /// <param name="persona"></param>
        /// <returns></returns>
        public int editarPersonaDAL(clsPersona persona)
        {
            clsMyConnection clsMyConnection = new clsMyConnection();
            SqlConnection sqlConnection = new SqlConnection();
            SqlCommand sqlCommand = new SqlCommand();

            int numeroFilasAfectadas = 0;

            sqlCommand.Parameters.Add("@ID", System.Data.SqlDbType.Int).Value = persona.ID;
            sqlCommand.Parameters.Add("@Nombre", System.Data.SqlDbType.NVarChar).Value = persona.Nombre;
            sqlCommand.Parameters.Add("@Apellidos", System.Data.SqlDbType.NVarChar).Value = persona.Apellidos == null ? (Object)DBNull.Value : persona.Apellidos;
            sqlCommand.Parameters.Add("@FechaNacimiento", System.Data.SqlDbType.Date).Value = persona.FechaNacimiento == new DateTime() ? (Object)DBNull.Value : persona.FechaNacimiento;
            sqlCommand.Parameters.Add("@Foto", System.Data.SqlDbType.VarBinary).Value = persona.Foto == null ? (Object)DBNull.Value : persona.Foto;
            sqlCommand.Parameters.Add("@Direccion", System.Data.SqlDbType.NVarChar).Value = persona.Direccion == null ? (Object)DBNull.Value : persona.Direccion;
            sqlCommand.Parameters.Add("@Telefono", System.Data.SqlDbType.NVarChar).Value = persona.Telefono == null ? (Object)DBNull.Value : persona.Telefono;
            sqlCommand.Parameters.Add("@IDDepartamento", System.Data.SqlDbType.Int).Value = persona.IDDepartamento == 0 ? (Object)DBNull.Value : persona.IDDepartamento;

            sqlCommand.CommandText = "UPDATE Personas SET " +
                "Nombre = @Nombre, " +
                "Apellidos = @Apellidos, " +
                "FechaNacimiento = @FechaNacimiento, " +
                "Foto = @Foto, " +
                "Direccion = @Direccion, " +
                "Telefono = @Telefono, " +
                "IDDepartamento = @IDDepartamento " +
                "WHERE ID = @ID";

            try
            {
                sqlConnection = clsMyConnection.getConnection();

                sqlCommand.Connection = sqlConnection;

                numeroFilasAfectadas = sqlCommand.ExecuteNonQuery();
            }
            catch (SqlException)
            {
                throw;
            }
            finally
            {
                clsMyConnection.closeConnection(ref sqlConnection);
            }


            return numeroFilasAfectadas;
        }

        /// <summary>
        /// Crear una persona en la base de datos a partir de un objeto persona
        /// </summary>
        /// <param name="persona"></param>
        /// <returns></returns>
        public int crearPersonaDAL(clsPersona persona)
        {
            clsMyConnection clsMyConnection = new clsMyConnection();
            SqlConnection sqlConnection = new SqlConnection();
            SqlCommand sqlCommand = new SqlCommand();

            int numeroFilasAfectadas = 0;

            sqlCommand.Parameters.Add("@Nombre", System.Data.SqlDbType.NVarChar).Value = persona.Nombre;
            sqlCommand.Parameters.Add("@Apellidos", System.Data.SqlDbType.NVarChar).Value = persona.Apellidos == null ? (Object)DBNull.Value : persona.Apellidos;
            sqlCommand.Parameters.Add("@FechaNacimiento", System.Data.SqlDbType.Date).Value = persona.FechaNacimiento == new DateTime() ? (Object)DBNull.Value : persona.FechaNacimiento;
            sqlCommand.Parameters.Add("@Foto", System.Data.SqlDbType.VarBinary).Value = persona.Foto == null ? (Object)DBNull.Value : persona.Foto;
            sqlCommand.Parameters.Add("@Direccion", System.Data.SqlDbType.NVarChar).Value = persona.Direccion == null ? (Object)DBNull.Value : persona.Direccion;
            sqlCommand.Parameters.Add("@Telefono", System.Data.SqlDbType.NVarChar).Value = persona.Telefono == null ? (Object)DBNull.Value : persona.Telefono;
            sqlCommand.Parameters.Add("@IDDepartamento", System.Data.SqlDbType.Int).Value = persona.IDDepartamento == 0 ? (Object)DBNull.Value : persona.IDDepartamento;

            sqlCommand.CommandText = "INSERT INTO Personas (Nombre, Apellidos, FechaNacimiento, Foto, Direccion, Telefono, IDDepartamento)" +
                " Values (@Nombre, @Apellidos, @FechaNacimiento, @Foto, @Direccion, @Telefono, @IDDepartamento)";
            try
            {
                sqlConnection = clsMyConnection.getConnection();

                sqlCommand.Connection = sqlConnection;

                numeroFilasAfectadas = sqlCommand.ExecuteNonQuery();
            }
            catch (SqlException)
            {
                throw;
            }
            finally
            {
                clsMyConnection.closeConnection(ref sqlConnection);
            }


            return numeroFilasAfectadas;
        }
    }
}
