using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ExamenUWPEntidades
{
    public class clsAula
    {
        #region Propiedades
        public int IDAula { get; set; }
        public String Nombre { get; set; }
        #endregion

        #region Constructores
        public clsAula(int IDAula, String nombre)
        {
            this.IDAula = IDAula;
            this.Nombre = nombre;
        }

        public clsAula()
        {

        }
        #endregion


    }
}
