using System;
using _11_CRUDPersonasDepartamentos_DAL.Conexion;
using _11_CRUDPersonasDepartamentos_Entidades;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;

namespace _11_CRUDPersonasDepartamentos_DAL.Manejadoras
{
    public class clsManejadoraDepartamentosDAL
    {
            /// <summary>
            /// Elimina un departamento en la base de datos a partir de su ID
            /// </summary>
            /// <param name="IDDepartamento"></param>
            /// <returns></returns>
            public int eliminarDepartamentoDAL(int IDDepartamento)
            {
                clsMyConnection clsMyConnection = new clsMyConnection();
                SqlConnection sqlConnection = new SqlConnection();
                SqlCommand sqlCommand = new SqlCommand();

                int numeroFilasAfectadas = 0;

                sqlCommand.Parameters.Add("@IDDepartamento", System.Data.SqlDbType.Int).Value = IDDepartamento;
                sqlCommand.CommandText = "DELETE FROM Departamentos WHERE ID = @IDDepartamento";

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
            /// Edita un departamento en la base de datos a partir de un objeto departamento
            /// </summary>
            /// <param name="departamento"></param>
            /// <returns></returns>
            public int editarDepartamentoDAL(clsDepartamento departamento)
            {
                clsMyConnection clsMyConnection = new clsMyConnection();
                SqlConnection sqlConnection = new SqlConnection();
                SqlCommand sqlCommand = new SqlCommand();

                int numeroFilasAfectadas = 0;

                sqlCommand.Parameters.Add("@ID", System.Data.SqlDbType.Int).Value = departamento.ID;
                sqlCommand.Parameters.Add("@Nombre", System.Data.SqlDbType.NVarChar).Value = departamento.Nombre;

                sqlCommand.CommandText = "UPDATE Departamentos SET " +
                    "Nombre = @Nombre " +
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
            /// Crear un departamento en la base de datos a partir de un objeto departamento
            /// </summary>
            /// <param name="departamento"></param>
            /// <returns></returns>
            public int crearDepartamentoDAL(clsDepartamento departamento)
            {
                clsMyConnection clsMyConnection = new clsMyConnection();
                SqlConnection sqlConnection = new SqlConnection();
                SqlCommand sqlCommand = new SqlCommand();

                int numeroFilasAfectadas = 0;

                sqlCommand.Parameters.Add("@Nombre", System.Data.SqlDbType.NVarChar).Value = departamento.Nombre;

                sqlCommand.CommandText = "INSERT INTO Departamentos (Nombre)" +
                    " Values (@Nombre)";
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

