using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace _10_ADO.NET_01.Controllers
{
    public class HomeController : Controller
    {
        // GET: Home
        public ActionResult Index()
        {
            return View();

        }

        [HttpPost, ActionName("Index")]
        public ActionResult IndexPost()
        {
            SqlConnection sqlConnection = new SqlConnection();

            sqlConnection.ConnectionString = "server = manucaba.database.windows.net; database = ManuCaba; uid = manucaba; pwd = Mitesoro1.;";

            try
            {
                sqlConnection.Open();

                ViewBag.State = sqlConnection.State.ToString();
            }
            catch(SqlException)
            {
                ViewBag.State = sqlConnection.State.ToString(); ;
            }
            finally
            {
                sqlConnection.Close();
            }


            return View();
        }
    }
}