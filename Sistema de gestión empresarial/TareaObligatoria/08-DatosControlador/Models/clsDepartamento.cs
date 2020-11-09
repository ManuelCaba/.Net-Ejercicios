using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace _08_DatosControlador.Models
{
    public class clsDepartamento
    {
        #region Propiedades
        public int ID { get; set; }
        public String Nombre { get; set; }
        #endregion

        #region Constructores
        public clsDepartamento()
        {
            this.ID = 0;
            this.Nombre = "";
        }

        public clsDepartamento(int ID, String nombre)
        {
            this.ID = ID;
            this.Nombre = nombre;
        }
        #endregion
    }
}