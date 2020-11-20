using _10_CRUDPersonas_DAL.Conexion;
using _10_CRUDPersonas_Entidades;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace _10_CRUDPersonas_DAL.Listados
{
    public class clsListadoPersonas
    {
        public List<clsPersona> listadoPersonas()
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
    }
}
