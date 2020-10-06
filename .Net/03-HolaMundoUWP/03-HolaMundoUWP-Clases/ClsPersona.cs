using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace _03_HolaMundoUWP_Clases
{
    public class ClsPersona
    {
        #region Atributos

        private String nombre;

        #endregion

        #region Constructores

        //Constructor por defecto
        public ClsPersona()
        {
            this.nombre = "";
            this.Edad = 0;
        }

        //Constructor con parámetros
        public ClsPersona(String nombre, int edad)
        {
            this.nombre = nombre;
            this.Edad = edad;
        }

        #endregion

        #region Propiedades

        //Propiedades nombre

        public String Nombre
        {
            get { return nombre; }
            set { nombre = value; }

        }

        //Propiedades edad

        public int Edad { get; set; }

        #endregion



    }
}
