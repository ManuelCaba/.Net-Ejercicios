using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ExamenUWPEntidades
{
    public class clsTemperatura
    {
        #region Propiedades
        public int IDAula { get; set; }
        public DateTime Fecha { get; set; }
        public double Temp1 { get; set; }
        public double Temp2 { get; set; }
        public double Temp3 { get; set; }
        #endregion

        #region Constructores
        public clsTemperatura(int idAula, DateTime fecha, double temp1, double temp2, double temp3)
        {
            this.IDAula = idAula;
            this.Fecha = fecha;
            this.Temp1 = temp1;
            this.Temp2 = temp2;
            this.Temp3 = temp3;
        }

        public clsTemperatura()
        {

        }
        #endregion
    }
}
