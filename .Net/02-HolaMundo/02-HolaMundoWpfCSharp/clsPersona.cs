using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

/*
 * Añadir propiedad de tipo string nombre
 * Crear constructor por defecto y con parametros
 */

namespace _02_HolaMundoWpfCSharp
{
    public class clsPersona
    {
        //Declaración de las propiedades de la clase
        private String nombre;

        #region Constructores
        //Constructor por defecto
        public clsPersona()
        {
            nombre = "Default";
        }

        //Constructor con parámetros
        public clsPersona(String nombre)
        {
            this.nombre = nombre;
        }

        #endregion

        //Getters y Setters

        //Nombre
        public String Nombre
        {
            get { return this.nombre; }
            set { this.nombre = value; }
        }
    }
}
