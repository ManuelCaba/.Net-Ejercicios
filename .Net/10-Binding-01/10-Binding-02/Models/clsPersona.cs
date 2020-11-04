using System;
using System.ComponentModel;

namespace _10_Binding_02.Models
{
    public class clsPersona : INotifyPropertyChanged
    {
        #region Atributos
        private String nombre;
        private String apellidos;
        private String nombreCompleto;
        #endregion

        #region Propiedades
        public int ID { get; set; }

        public String Nombre 
        { 
            get { return nombre; }
            set
            { 
                nombre = value;
                NotifyPropertyChanged("NombreCompleto");
            } 
        }

        public String Apellidos
        {
            get { return apellidos; }
            set 
            { 
                apellidos = value;
                NotifyPropertyChanged("NombreCompleto");
            }
        }

        public String NombreCompleto
        {
            get { return nombre+" "+apellidos; }
            set { NombreCompleto = value; }
        }

        public int edad { get; set; }

        public event PropertyChangedEventHandler PropertyChanged;
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

        #region INotifyPropertyChanged

        private void NotifyPropertyChanged(String property)
        {
            if(PropertyChanged != null)
            {
                PropertyChanged(this, new PropertyChangedEventArgs(property));
            }
        }

        #endregion
    }
}
