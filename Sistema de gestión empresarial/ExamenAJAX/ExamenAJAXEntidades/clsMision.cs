using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ExamenAJAXEntidades
{
    public class clsMision
    {
        #region Propiedades
        public int id { get; set; }
        public String nombre { get; set; }
        public String descripcion { get; set; }
        public int creditos { get; set; }
        public bool completada { get; set; }
        #endregion

        #region Constructores
        public clsMision()
        {
            id = 0;
            nombre = "";
            descripcion = "";
            creditos = 0;
            completada = false;
        }

        public clsMision(int id, String nombre, String descripcion, int creditos, bool completada)
        {
            this.id = id;
            this.nombre = nombre;
            this.descripcion = descripcion;
            this.creditos = creditos;
            this.completada = completada;
        }
        #endregion
    }
}
