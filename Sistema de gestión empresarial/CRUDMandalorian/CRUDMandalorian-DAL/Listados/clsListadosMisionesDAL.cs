using CRUDMandalorian_Entidades;
using CRUDMandalorian_DAL.Conexion;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CRUDMandalorian_DAL.Listados
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

        /// <summary>
        /// Devuelve una mision por su ID
        /// </summary>
        /// <param name="IDMision"></param>
        /// <returns></returns>
        public clsMision obtenerMisionPorIDDAL(int IDMision)
        {
            clsMyConnection clsMyConnection = new clsMyConnection();
            SqlConnection sqlConnection = new SqlConnection();
            SqlCommand sqlCommand = new SqlCommand();
            SqlDataReader miLector;
            clsMision mision = new clsMision();

            sqlCommand.Parameters.Add("@IDMision", System.Data.SqlDbType.Int).Value = IDMision;
            sqlCommand.CommandText = "SELECT id, nombre, descripcion, creditos, completada FROM Misiones WHERE id = @IDMision";

            try
            {
                sqlConnection = clsMyConnection.getConnection();

                sqlCommand.Connection = sqlConnection;

                miLector = sqlCommand.ExecuteReader();

                if (miLector.HasRows)
                {
                    miLector.Read();

                    mision = new clsMision();
                    mision.id = (int)miLector["id"];
                    mision.nombre = (String)miLector["nombre"];
                    mision.descripcion = (String)miLector["descripcion"];
                    mision.creditos = (int)miLector["creditos"];
                    mision.completada = miLector["completada"] == DBNull.Value ? false : (bool)miLector["completada"];
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


            return mision;
        }
    }
}
