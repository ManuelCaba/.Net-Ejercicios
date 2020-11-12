using _11_BindingCommand_01.Models;
using _11_BindingCommand_01.ViewModels.Utilidades;
using System;
using System.Collections.ObjectModel;
using System.ComponentModel;
using Windows.UI.Xaml;

namespace _11_BindingCommand_01.ViewModels
{
    public class MainPageVM : clsVMBase
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
                    NotifyPropertyChanged("ViewModel.PersonaSeleccionada");
                }
        }
        #endregion

        #region Constructores
        public MainPageVM()
        {
            //Rellenamos el listado de personas porque hace falta nada mas entrar en la página
            ListadoPersonas = clsListados.listadoPersonas();
        }
        #endregion

        #region Métodos
        public void eliminarPersona(Object sender, RoutedEventArgs e)
        {
            ListadoPersonas.Remove(PersonaSeleccionada);
        }
        #endregion
    }
}
