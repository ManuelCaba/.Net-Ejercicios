using CRUDMandalorian_Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CRUDMandalorian_UI.Models
{
    public class clsListadoMisionesConMisionSeleccionada : clsMision
    {
        #region Propiedades
        public List<clsMision> listadoMisionesPendientes { get; set; }
        #endregion

        #region Constructores
        public clsListadoMisionesConMisionSeleccionada() : base()
        {
            listadoMisionesPendientes = null;
        }

        public clsListadoMisionesConMisionSeleccionada(clsMision mision, List<clsMision> listadoMisionesPendientes) 
            : base(mision.id, mision.nombre, mision.descripcion, mision.creditos, mision.completada)
        {
            this.listadoMisionesPendientes = listadoMisionesPendientes;
        }

        public clsListadoMisionesConMisionSeleccionada(int id, String nombre, String descripcion, int creditos, bool completada, List<clsMision> listadoMisionesPendientes) 
            : base(id, nombre, descripcion, creditos, completada)
        {
            this.listadoMisionesPendientes = listadoMisionesPendientes;
        }
        #endregion
    }
}