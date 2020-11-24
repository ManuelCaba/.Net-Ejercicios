using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace _10_CRUDPersonas_Entidades
{
    public class clsDepartamento
    {
        #region Propiedades
        public int ID { get; set; }

        public String Nombre { get; set; }
        #endregion

        #region Constructores
        public clsDepartamento(int ID, String nombre)
        {
            this.ID = ID;
            Nombre = nombre;
        }

        public clsDepartamento()
        {
            ID = 0;
            Nombre = "";
        }
        #endregion
    }
}
