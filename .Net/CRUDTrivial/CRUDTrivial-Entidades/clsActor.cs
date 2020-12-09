using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CRUDTrivial_Entidades
{
    public class clsActor
    {
        #region Propiedades
        public int ID { get; set; }

        public String Nombre { get; set; }
        #endregion

        #region Constructores
        public clsActor(int ID, String nombre)
        {
            this.ID = ID;
            Nombre = nombre;
        }

        public clsActor()
        {
            ID = 0;
            Nombre = "";
        }
        #endregion
    }
}
