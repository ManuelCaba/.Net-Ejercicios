using System;
using _11_CRUDPersonasDepartamentos_DAL.Conexion;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using _11_CRUDPersonasDepartamentos_Entidades;

namespace _11_CRUDPersonasDepartamentos_DAL.Listados
{
    public class clsListadoDepartamentos
    {
        public String nombreDepartamentoPorPersona(int IDPersona)
        {
            clsMyConnection clsMyConnection = new clsMyConnection();
            SqlConnection sqlConnection = new SqlConnection();
            SqlCommand sqlCommand = new SqlCommand();
            SqlDataReader miLector;
            String nombreDepartamento = "";

            sqlCommand.Parameters.Add("@IDPersona", System.Data.SqlDbType.Int).Value = IDPersona;
            sqlCommand.CommandText = "SELECT D.Nombre AS NombreDepartamento FROM Personas AS P INNER JOIN Departamentos AS D ON P.IDDepartamento = D.ID WHERE P.ID = @IDPersona";

            try
            {
                sqlConnection = clsMyConnection.getConnection();

                sqlCommand.Connection = sqlConnection;

                miLector = sqlCommand.ExecuteReader();

                if (miLector.HasRows)
                {
                    miLector.Read();

                    nombreDepartamento = (String) miLector["NombreDepartamento"];
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


            return nombreDepartamento;
        }

        public List<clsDepartamento> listadoDepartamentos()
        {
            clsMyConnection clsMyConnection = new clsMyConnection();
            SqlConnection sqlConnection = new SqlConnection();
            SqlCommand sqlCommand = new SqlCommand();
            SqlDataReader miLector;
            List<clsDepartamento> listadoDepartamentos = new List<clsDepartamento>();
            clsDepartamento oDepartamento;

            sqlCommand.CommandText = "SELECT ID, Nombre FROM Departamentos";

            try
            {
                sqlConnection = clsMyConnection.getConnection();

                sqlCommand.Connection = sqlConnection;

                miLector = sqlCommand.ExecuteReader();

                if (miLector.HasRows)
                {
                    while(miLector.Read())
                    {
                        oDepartamento = new clsDepartamento();

                        oDepartamento.ID = (int) miLector["ID"];
                        oDepartamento.Nombre = miLector["Nombre"] == DBNull.Value ? null : (String)miLector["Nombre"];

                        listadoDepartamentos.Add(oDepartamento);
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


            return listadoDepartamentos;
        }
    }
}
