using ExamenUWPDAL.Conexion;
using ExamenUWPEntidades;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ExamenUWPDAL.Listados
{
    public class clsListadoTemperaturasDAL
    {
        /// <summary>
        /// Devuelve una temperatura según una fecha y un IDAula
        /// </summary>
        /// <param name="IDAula"></param>
        /// <param name="fecha"></param>
        /// <returns></returns>
        public clsTemperatura temperaturasPorAulaYFecha(int IDAula, DateTime fecha)
        {
            clsMyConnection clsMyConnection = new clsMyConnection();
            SqlConnection sqlConnection = new SqlConnection();
            SqlCommand sqlCommand = new SqlCommand();
            SqlDataReader miLector;
            clsTemperatura oTemperatura = new clsTemperatura();

            sqlCommand.Parameters.Add("@IDAula", System.Data.SqlDbType.Int).Value = IDAula;
            sqlCommand.Parameters.Add("@Fecha", System.Data.SqlDbType.Date).Value = fecha;
            sqlCommand.CommandText = "SELECT idAula,fecha,temp1,temp2,temp3 FROM temperaturas WHERE idAula = @IDAula AND fecha = @Fecha";

            try
            {
                sqlConnection = clsMyConnection.getConnection();

                sqlCommand.Connection = sqlConnection;

                miLector = sqlCommand.ExecuteReader();

                if (miLector.HasRows)
                {
                    miLector.Read();
                    oTemperatura = new clsTemperatura();
                    oTemperatura.IDAula = (int)miLector["idAula"];
                    oTemperatura.Fecha = (DateTime)miLector["fecha"];
                    oTemperatura.Temp1 = miLector["temp1"] == DBNull.Value ? 0 : (double)miLector["temp1"];
                    oTemperatura.Temp2 = miLector["temp2"] == DBNull.Value ? 0 : (double)miLector["temp2"];
                    oTemperatura.Temp3 = miLector["temp3"] == DBNull.Value ? 0 : (double)miLector["temp3"];
           
                }

                miLector.Close();
            }
            catch (SqlException)
            {
                throw;
            }
            finally
            {
                clsMyConnection.closeConnection(ref sqlConnection);
            }


            return oTemperatura;
        }
    }
}
