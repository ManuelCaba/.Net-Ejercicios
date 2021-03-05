using ExamenAJAXDAL.Conexion;
using ExamenAJAXEntidades;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ExamenAJAXDAL.Listados
{
    public class clsListadosMisionesDAL
    {
        /// <summary>
        /// Devuelve un listado completo de las misiones no terminadas
        /// </summary>
        /// <returns></returns>
        public List<clsMision> listadoMisionesPendientesDAL()
        {
            clsMyConnection clsMyConnection = new clsMyConnection();
            SqlConnection sqlConnection = new SqlConnection();
            SqlCommand sqlCommand = new SqlCommand();
            SqlDataReader miLector;
            clsMision oMision;
            List<clsMision> listadoMisiones = new List<clsMision>();

            sqlCommand.CommandText = "SELECT id, nombre, descripcion, creditos, completada FROM Misiones WHERE completada = 0";

            try
            {
                sqlConnection = clsMyConnection.getConnection();

                sqlCommand.Connection = sqlConnection;

                miLector = sqlCommand.ExecuteReader();

                if (miLector.HasRows)
                {
                    while (miLector.Read())
                    {
                        oMision = new clsMision();
                        oMision.id = (int)miLector["id"];
                        oMision.nombre = (String)miLector["nombre"];
                        oMision.descripcion = (String)miLector["descripcion"];
                        oMision.creditos = (int)miLector["creditos"];
                        oMision.completada = miLector["completada"] == DBNull.Value ? false : (bool)miLector["completada"];
                        listadoMisiones.Add(oMision);
                    }
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


            return listadoMisiones;
        }
    }
}
