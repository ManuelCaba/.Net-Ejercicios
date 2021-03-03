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
    public class clsListadoAulasDAL
    {
        /// <summary>
        /// Devuelve un listado completo de aulas
        /// </summary>
        /// <returns></returns>
        public List<clsAula> listadoAulasDAL()
        {
            clsMyConnection clsMyConnection = new clsMyConnection();
            SqlConnection sqlConnection = new SqlConnection();
            SqlCommand sqlCommand = new SqlCommand();
            SqlDataReader miLector;
            clsAula oAula;
            List<clsAula> listadoAulas = new List<clsAula>();

            sqlCommand.CommandText = "SELECT id, nombre FROM aulas";

            try
            {
                sqlConnection = clsMyConnection.getConnection();

                sqlCommand.Connection = sqlConnection;

                miLector = sqlCommand.ExecuteReader();

                if (miLector.HasRows)
                {
                    while (miLector.Read())
                    {
                        oAula = new clsAula();
                        oAula.IDAula = (int)miLector["id"];
                        oAula.Nombre = (String)miLector["nombre"];
                        listadoAulas.Add(oAula);
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


            return listadoAulas;
        }
    }
}
