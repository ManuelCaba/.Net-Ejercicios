using CRUDTrivial_DAL.Conexion;
using CRUDTrivial_Entidades;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;

namespace CRUDTrivial_DAL.Listados
{
    public class clsListadosActoresDAL
    {
        /// <summary>
        /// Devuelve un listado completo de actores
        /// </summary>
        /// <returns></returns>
        public List<clsActor> listadoActoresDAL()
        {
            clsMyConnection clsMyConnection = new clsMyConnection();
            SqlConnection sqlConnection = new SqlConnection();
            SqlCommand sqlCommand = new SqlCommand();
            SqlDataReader miLector;
            clsActor oActor;
            List<clsActor> listadoActores = new List<clsActor>();

            sqlCommand.CommandText = "SELECT id, nombre FROM Actores";

            try
            {
                sqlConnection = clsMyConnection.getConnection();

                sqlCommand.Connection = sqlConnection;

                miLector = sqlCommand.ExecuteReader();

                if (miLector.HasRows)
                {
                    while (miLector.Read())
                    {
                        oActor = new clsActor();
                        oActor.ID = (int)miLector["ID"];
                        oActor.Nombre = (String)miLector["Nombre"];

                        listadoActores.Add(oActor);
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


            return listadoActores;
        }
    }
}
