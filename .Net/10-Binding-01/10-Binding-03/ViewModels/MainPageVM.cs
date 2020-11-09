using _10_Binding_03.Models;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace _10_Binding_03.ViewModels
{
    public class MainPageVM : INotifyPropertyChanged
    {
        #region Atributos
        private clsPersona personaSeleccionada;
    #endregion

    #region Propiedades
    public ObservableCollection<clsPersona> ListadoPersonas { get; set; }
    public clsPersona PersonaSeleccionada 
    { 
            get
            {
                return personaSeleccionada;
            }

            set
            {
                personaSeleccionada = value;
                NotifyPropertyChanged("PersonaSeleccionada");
            }
    }

    public event PropertyChangedEventHandler PropertyChanged;
    #endregion

        #region Constructores
        public MainPageVM()
    {
        ListadoPersonas = clsListados.listadoPersonas();
    }
    #endregion

        #region INotifyPropertyChanged

        private void NotifyPropertyChanged(String property)
        {
            if (PropertyChanged != null)
            {
                PropertyChanged(this, new PropertyChangedEventArgs(property));
            }
        }

        #endregion


    }
}
