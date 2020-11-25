using System;
using System.Data.SqlClient;
using _10_CRUDPersonas_DAL.Conexion;
using _10_CRUDPersonas_Entidades;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace _10_CRUDPersonas_DAL.Listados
{
    public class clsListadoDepartamentosDAL
    {
        public String nombreDepartamentoPorIDDAL(int IDDepartamento)
        {
            clsMyConnection clsMyConnection = new clsMyConnection();
            SqlConnection sqlConnection = new SqlConnection();
            SqlCommand sqlCommand = new SqlCommand();
            SqlDataReader miLector;
            String nombreDepartamento = "";

            sqlCommand.Parameters.Add("@IDDepartamento", System.Data.SqlDbType.Int).Value = IDDepartamento;
            sqlCommand.CommandText = "SELECT Nombre FROM Departamentos WHERE ID = @IDDepartamento";

            try
            {
                sqlConnection = clsMyConnection.getConnection();

                sqlCommand.Connection = sqlConnection;

                miLector = sqlCommand.ExecuteReader();

                if (miLector.HasRows)
                {
                    miLector.Read();

                    nombreDepartamento = (String) miLector["Nombre"];
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

        public List<clsDepartamento> listadoDepartamentosDAL()
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
