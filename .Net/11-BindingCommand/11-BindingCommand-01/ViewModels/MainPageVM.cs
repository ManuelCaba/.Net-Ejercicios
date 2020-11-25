using _11_BindingCommand_01.Models;
using _11_BindingCommand_01.ViewModels.Utilidades;
using System;
using System.Collections.ObjectModel;
using System.ComponentModel;
using Windows.UI.Xaml;
using Windows.UI.Xaml.Controls;

namespace _11_BindingCommand_01.ViewModels
{
    public class MainPageVM : clsVMBase
    {
        #region Atributos
        private ObservableCollection<clsPersona> listadoPersonas;
        private ObservableCollection<clsPersona> listadoPersonasBuscadas;
        private clsPersona personaSeleccionada;
        private String buscar;
        #endregion

        #region Propiedades
        public ObservableCollection<clsPersona> ListadoPersonasBuscadas 
        { 
            get
            {
                return listadoPersonasBuscadas;
            }
        }

        public clsPersona PersonaSeleccionada 
        { 
                get
                {
                    return personaSeleccionada;
                }

                set
                {
                    if(personaSeleccionada != value)
                    {
                        personaSeleccionada = value;
                        NotifyPropertyChanged("PersonaSeleccionada");
                        EliminarCommand.RaiseCanExecuteChanged();
                    }
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
                    listadoPersonasBuscadas = new ObservableCollection<clsPersona>(listadoPersonas);
                    NotifyPropertyChanged("ListadoPersonasBuscadas");
                }
            }
        }

        public DelegateCommand BuscarCommand { get; }

        public DelegateCommand EliminarCommand { get; }
        #endregion

        #region Constructores
        public MainPageVM()
        {
            BuscarCommand = new DelegateCommand(BuscarCommand_Executed, BuscarCommand_CanExecute);
            EliminarCommand = new DelegateCommand(EliminarCommand_ExecutedAsync, EliminarCommand_CanExecute);
            //Rellenamos el listado de personas porque hace falta nada mas entrar en la página
            listadoPersonas = clsListados.listadoPersonas();
            listadoPersonasBuscadas = new ObservableCollection<clsPersona>(listadoPersonas);
        }
        #endregion

        #region Métodos
        public void eliminarPersona(Object sender, RoutedEventArgs e)
        {
            if(personaSeleccionada != null)
            {
                listadoPersonas.Remove(PersonaSeleccionada);
            }
        }

        private async void EliminarCommand_ExecutedAsync()
        {
            ContentDialog deleteFileDialog = new ContentDialog
            {
                Title = "Desea borrar la persona seleccionada?",
                Content = "Si lo borras, no podras recuperarla. Quieres borrarlo?",
                PrimaryButtonText = "Borrar",
                CloseButtonText = "Cancelar"
            };

            ContentDialogResult result = await deleteFileDialog.ShowAsync();

            // Borrar la persona si el usuario pulsa el botón primario.
            /// En otro lugar, nada.
            if (result == ContentDialogResult.Primary)
            {
                listadoPersonas.Remove(PersonaSeleccionada);
                listadoPersonasBuscadas.Remove(PersonaSeleccionada);
            }

            PersonaSeleccionada = null;

        }

        private bool EliminarCommand_CanExecute()
        {
            bool canExecute = true;

            if (PersonaSeleccionada == null)
            {
                canExecute = false;
            }

            return canExecute;
        }

        private void BuscarCommand_Executed()
        {
            listadoPersonasBuscadas.Clear();

            foreach(clsPersona persona in listadoPersonas)
            {
                if(persona.Nombre.ToLower().Contains(buscar.ToLower()) || persona.Apellidos.ToLower().Contains(buscar.ToLower()))
                {
                    listadoPersonasBuscadas.Add(persona);
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
