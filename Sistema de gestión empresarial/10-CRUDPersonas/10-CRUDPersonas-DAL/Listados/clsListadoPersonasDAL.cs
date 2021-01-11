using _10_CRUDPersonas_DAL.Conexion;
using _10_CRUDPersonas_Entidades;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;

namespace _10_CRUDPersonas_DAL.Listados
{
    public class clsListadoPersonasDAL
    {
        /// <summary>
        /// Devuelve un listado completo de personas
        /// </summary>
        /// <returns></returns>
        public List<clsPersona> listadoPersonasDAL()
        {
            clsMyConnection clsMyConnection = new clsMyConnection();
            SqlConnection sqlConnection = new SqlConnection();
            SqlCommand sqlCommand = new SqlCommand();
            SqlDataReader miLector;
            clsPersona oPersona;
            List<clsPersona> listadoPersonas = new List<clsPersona>();

            sqlCommand.CommandText = "SELECT ID, Nombre, Apellidos, FechaNacimiento, Foto, Direccion, Telefono, IDDepartamento FROM Personas";

            try
            {
                sqlConnection = clsMyConnection.getConnection();

                sqlCommand.Connection = sqlConnection;

                miLector = sqlCommand.ExecuteReader();

                if (miLector.HasRows)
                {
                    while (miLector.Read())
                    {
                        oPersona = new clsPersona();
                        oPersona.ID = (int)miLector["ID"];
                        oPersona.Nombre = (String)miLector["Nombre"];
                        oPersona.Apellidos = miLector["Apellidos"] == DBNull.Value ? null : (String)miLector["Apellidos"];
                        oPersona.FechaNacimiento = miLector["FechaNacimiento"] == DBNull.Value ? new DateTime() : (DateTime)miLector["FechaNacimiento"];
                        oPersona.Foto = miLector["Foto"] == DBNull.Value ? null : (byte[])miLector["Foto"];
                        oPersona.Direccion = miLector["Direccion"] == DBNull.Value ? null : (String)miLector["Direccion"];
                        oPersona.Telefono = miLector["Telefono"] == DBNull.Value ? null : (String)miLector["Telefono"];
                        oPersona.IDDepartamento = miLector["IDDepartamento"] == DBNull.Value ? 0 : (int)miLector["IDDepartamento"];
                        listadoPersonas.Add(oPersona);
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


            return listadoPersonas;
        }

        /// <summary>
        /// Devuelve una persona por su ID
        /// </summary>
        /// <param name="IDPersona"></param>
        /// <returns></returns>
        public clsPersona obtenerPersonaPorIDDAL(int IDPersona)
        {
            clsMyConnection clsMyConnection = new clsMyConnection();
            SqlConnection sqlConnection = new SqlConnection();
            SqlCommand sqlCommand = new SqlCommand();
            SqlDataReader miLector;
            clsPersona persona = new clsPersona();

            sqlCommand.Parameters.Add("@IDPersona", System.Data.SqlDbType.Int).Value = IDPersona;
            sqlCommand.CommandText = "SELECT ID, Nombre, Apellidos, FechaNacimiento, Foto, Direccion, Telefono, IDDepartamento FROM Personas WHERE ID = @IDPersona";

            try
            {
                sqlConnection = clsMyConnection.getConnection();

                sqlCommand.Connection = sqlConnection;

                miLector = sqlCommand.ExecuteReader();

                if (miLector.HasRows)
                {
                    miLector.Read();

                    persona.ID = (int)miLector["ID"];
                    persona.Nombre = (String)miLector["Nombre"];
                    persona.Apellidos = miLector["Apellidos"] == DBNull.Value ? null : (String)miLector["Apellidos"];
                    persona.FechaNacimiento = miLector["FechaNacimiento"] == DBNull.Value ? new DateTime() : (DateTime)miLector["FechaNacimiento"];
                    persona.Foto = miLector["Foto"] == DBNull.Value ? null : (byte[])miLector["Foto"];
                    persona.Direccion = miLector["Direccion"] == DBNull.Value ? null : (String)miLector["Direccion"];
                    persona.Telefono = miLector["Telefono"] == DBNull.Value ? null : (String)miLector["Telefono"];
                    persona.IDDepartamento = miLector["IDDepartamento"] == DBNull.Value ? 0 : (int)miLector["IDDepartamento"];
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


            return persona;
        }
    }
}
