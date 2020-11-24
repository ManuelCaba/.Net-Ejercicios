using System;
using System.Collections.Generic;
using _10_CRUDPersonas_DAL.Conexion;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;

namespace _10_CRUDPersonas_DAL.Manejadoras
{
    public class clsManejadoraPersonas
    {
        public int eliminarPersona(int IDPersona)
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
    }
}
