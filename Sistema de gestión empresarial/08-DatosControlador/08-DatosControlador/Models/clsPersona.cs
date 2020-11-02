using System;

namespace _08_DatosControlador.Models
{
    public class clsPersona
    {
        #region Propiedades
        public int ID { get; set; }
        public String nombre { get; set; }
        public String apellidos { get; set; }
        public int edad { get; set; }
        #endregion

        #region Constructores
        public clsPersona(int ID, String nombre, String apellidos, int edad)
        {
            this.ID = ID;
            this.nombre = nombre;
            this.apellidos = apellidos;
            this.edad = edad;
        }

        public clsPersona()
        {
            this.ID = 0;
            this.nombre = "";
            this.apellidos = "";
            this.edad = 0;   
        }
        #endregion
    }
}
