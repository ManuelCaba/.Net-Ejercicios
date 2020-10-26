using System;

namespace _07_MVCInicioUI.Models
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
        #endregion
    }
}
