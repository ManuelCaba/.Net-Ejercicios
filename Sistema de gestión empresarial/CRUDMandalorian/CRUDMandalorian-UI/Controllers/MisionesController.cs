using CRUDMandalorian_DAL.Listados;
using CRUDMandalorian_DAL.Manejadoras;
using CRUDMandalorian_UI.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using CRUDMandalorian_Entidades;
using System.Data.SqlClient;

namespace CRUDMandalorian_UI.Controllers
{
    public class MisionesController : Controller
    {
        // GET: Misiones
        public ActionResult Index()
        {
            try
            {
                clsListadoMisionesConMisionSeleccionada IndexVM;
                clsListadosMisionesBL clsListadosMisiones = new clsListadosMisionesBL();

                IndexVM = new clsListadoMisionesConMisionSeleccionada(new clsMision(), clsListadosMisiones.listadoMisionesPendientesBL());


                return View(IndexVM);
            }
            catch (SqlException)
            {
                return View("ErrorPage");
            }

        }

        [HttpPost]
        public ActionResult Index(clsListadoMisionesConMisionSeleccionada IndexVM, String boton)
        {
            try
            {
                clsListadosMisionesBL clsListadosMisiones = new clsListadosMisionesBL();
                clsManejadoraMisionesBL clsManejadoraMisiones = new clsManejadoraMisionesBL();

                if (boton.Equals("Ver Descripcion"))
                {
                    return View(new clsListadoMisionesConMisionSeleccionada(clsListadosMisiones.obtenerMisionPorIDDBL(IndexVM.id), clsListadosMisiones.listadoMisionesPendientesBL()));
                }
                else
                {
                    clsManejadoraMisiones.modificarPrecioBL(IndexVM.id, IndexVM.creditos);

                    return View(new clsListadoMisionesConMisionSeleccionada(new clsMision(), clsListadosMisiones.listadoMisionesPendientesBL()));
                }
            }
            catch(SqlException)
            {
                return View("ErrorPage");
            }
        }
    }
}