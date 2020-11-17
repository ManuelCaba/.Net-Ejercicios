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
        private ObservableCollection<clsPersona> ListadoPersonas;
        private clsPersona personaSeleccionada;
        private String buscar;
        #endregion

        #region Propiedades
        public ObservableCollection<clsPersona> ListadoPersonasBuscadas { get; set; }

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

        public String Buscar
        {
            get
            {
                return buscar;
            }

            set
            {
                buscar = value;
                BuscarCommand.RaiseCanExecuteChanged();

                if(String.IsNullOrEmpty(buscar))
                {
                    ListadoPersonasBuscadas.Clear();

                    foreach (clsPersona persona in ListadoPersonas)
                    {
                        if (persona.Nombre.ToLower().Contains(buscar.ToLower()) || persona.Apellidos.ToLower().Contains(buscar.ToLower()))
                        {
                            ListadoPersonasBuscadas.Add(persona);
                        }
                    }
                    //ObservableCollection<clsPersona> aux = new ObservableCollection<clsPersona>(ListadoPersonas);
                    //ListadoPersonasBuscadas = aux;
                    //NotifyPropertyChanged("ViewModel.ListadoPersonasBuscadas");
                }
            }
        }

        public DelegateCommand BuscarCommand { get; }
        #endregion

        #region Constructores
        public MainPageVM()
        {
            BuscarCommand = new DelegateCommand(BuscarCommand_Executed, BuscarCommand_CanExecute);
            //Rellenamos el listado de personas porque hace falta nada mas entrar en la página
            ListadoPersonas = clsListados.listadoPersonas();
            ListadoPersonasBuscadas = new ObservableCollection<clsPersona>(ListadoPersonas);
        }
        #endregion

        #region Métodos
        public void eliminarPersona(Object sender, RoutedEventArgs e)
        {
            if(personaSeleccionada != null)
            {
                ListadoPersonas.Remove(PersonaSeleccionada);
            }
        }

        private void BuscarCommand_Executed()
        {
            ListadoPersonasBuscadas.Clear();

            foreach(clsPersona persona in ListadoPersonas)
            {
                if(persona.Nombre.ToLower().Contains(buscar.ToLower()) || persona.Apellidos.ToLower().Contains(buscar.ToLower()))
                {
                    ListadoPersonasBuscadas.Add(persona);
                }
            }
        }

        private bool BuscarCommand_CanExecute()
        {
            bool canExecute = true;

            if(String.IsNullOrEmpty(buscar))
            {
                canExecute = false;
            }

            return canExecute;
        }
        #endregion
    }
}
