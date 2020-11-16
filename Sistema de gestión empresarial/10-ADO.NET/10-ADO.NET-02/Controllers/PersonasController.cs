using _10_ADO.NET_02.Models;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Web.Mvc;

namespace _10_ADO.NET_02.Controllers
{
    public class PersonasController : Controller
    {
        // GET: Personas
        public ActionResult Listado()
        {
            SqlConnection sqlConnection = new SqlConnection();
            SqlCommand sqlCommand = new SqlCommand();
            SqlDataReader miLector;
            clsPersona oPersona;
            List<clsPersona> listadoPersonas = new List<clsPersona>();

            sqlConnection.ConnectionString = "server = manucaba.database.windows.net; database = ManuCaba; uid = manucaba; pwd = Mitesoro1.;";
            sqlCommand.CommandText = "SELECT ID, Nombre, Apellidos, FechaNacimiento, Foto, Direccion, Telefono, IDDepartamento FROM Personas";
            sqlCommand.Connection = sqlConnection;

            try
            {
                sqlConnection.Open();

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
                ViewBag.State = "Error";
            }
            finally
            {
                sqlConnection.Close();
            }


            return View(listadoPersonas);
        }
    }
}