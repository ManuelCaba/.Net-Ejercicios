﻿using System;
using System.Collections.Generic;
using CRUDMandalorian_DAL.Conexion;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using CRUDMandalorian_Entidades;

namespace CRUDMandalorian_DAL.Manejadoras
{
    public class clsManejadoraMisionesDAL
    {
        /// <summary>
        /// Modifica el precio de una misión
        /// </summary>
        /// <param name="IDMision"></param>
        /// <param name="precio"></param>
        /// <returns></returns>
        public int modificarPrecioDAL(int IDMision, int precio)
        {
            clsMyConnection clsMyConnection = new clsMyConnection();
            SqlConnection sqlConnection = new SqlConnection();
            SqlCommand sqlCommand = new SqlCommand();

            int numeroFilasAfectadas = 0;

            sqlCommand.Parameters.Add("@ID", System.Data.SqlDbType.Int).Value = IDMision;
            sqlCommand.Parameters.Add("@Precio", System.Data.SqlDbType.NVarChar).Value = precio;

            sqlCommand.CommandText = "UPDATE Misiones SET " +
                "creditos = @precio " +
                "WHERE id = @ID";

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
