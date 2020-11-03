using System;

namespace _10_Binding_02.Models
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
            this.ID = 1;
            this.nombre = "Manuel";
            this.apellidos = "Caballero";
            this.edad = 20;
        }
        #endregion
    }
}
