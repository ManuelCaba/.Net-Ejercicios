using CRUDPersonasXamarin.Listados;
using CRUDPersonasXamarin_Entidades;
using CRUDPersonasXamarinUI.Utilidades;
using CRUDPersonasXamarinUI.ViewModels.Utilidades;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Threading.Tasks;
using Windows.UI.Xaml.Controls;

namespace CRUDPersonasXamarinUI.ViewModels
{
    public class PersonasVM : Utilidades.clsVMBase, IAsyncInitialization
    {
        #region Atributos
        private String buscar;
        private clsPersona personaSeleccionada;
        private List<clsPersona> listadoPersonasCompleto;
        #endregion

        #region Propiedades
        public Task Initialization { get; private set; }
        public String TextoBuscado { get; set; }
        public DelegateCommand BuscarCommand { get; }
        public DelegateCommand EliminarCommand { get; }
        public DelegateCommand CrearCommand { get; }
        public ObservableCollection<clsPersona> ListadoPersonasBuscadas { get; set; }
        public clsPersona PersonaSeleccionada
        {
            get
            {
                return personaSeleccionada;
            }

            set
            {
                if(personaSeleccionada != value && value != null)
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

                if (String.IsNullOrEmpty(buscar))
                {
                    ListadoPersonasBuscadas = new ObservableCollection<clsPersona>(listadoPersonasCompleto);
                    NotifyPropertyChanged("ListadoPersonasBuscadas");
                }
            }
        }
        #endregion

        #region Constructores
        public PersonasVM()
        {
            BuscarCommand = new DelegateCommand(BuscarCommand_Executed, BuscarCommand_CanExecute);
            //EliminarCommand = new DelegateCommand(EliminarCommand_Executed, EliminarCommand_CanExecute);
            CrearCommand = new DelegateCommand(CrearCommand_Executed);
            Initialization = InitializeAsync();

        }
        #endregion

        #region Métodos

        //Eliminar

        public async Task InitializeAsync()
        {
            clsListadoPersonasBL clsListadoPersonasBL = new clsListadoPersonasBL();
            listadoPersonasCompleto = await clsListadoPersonasBL.listadoPersonasBLAsync().ConfigureAwait(false);
            ListadoPersonasBuscadas = new ObservableCollection<clsPersona>(listadoPersonasCompleto);
            NotifyPropertyChanged("ListadoPersonasBuscadas");
        }

        //Buscar
        private void BuscarCommand_Executed()
        {
            ListadoPersonasBuscadas.Clear();

            foreach (clsPersona persona in listadoPersonasCompleto)
            {
               
                if (persona.Nombre.ToLower().Contains(buscar.ToLower()))
                {
                    ListadoPersonasBuscadas.Add(persona);
                }
                else if (!String.IsNullOrEmpty(persona.Apellidos))
                {
                    if (persona.Apellidos.ToLower().Contains(buscar.ToLower()))
                    {
                        ListadoPersonasBuscadas.Add(persona);
                    }
                }

            }
        }

        private bool BuscarCommand_CanExecute()
        {
            bool canExecute = true;

            if (String.IsNullOrEmpty(buscar))
            {
                canExecute = false;
            }

            return canExecute;
        }

        //Crear
        private void CrearCommand_Executed()
        {
            personaSeleccionada = null;

            NotifyPropertyChanged("PersonaSeleccionada");

            personaSeleccionada = new clsPersona();

            personaSeleccionada.ID = 0;
            personaSeleccionada.Nombre = "";
            personaSeleccionada.Apellidos = "";
            personaSeleccionada.FechaNacimiento = new DateTime();
            personaSeleccionada.Foto = null;
            personaSeleccionada.Direccion = "";
            personaSeleccionada.Telefono = "";
            personaSeleccionada.IDDepartamento = 1;

            NotifyPropertyChanged("PersonaSeleccionada");      
        }

        //Dialog
        //private async Task dialogErrorAsync()
        //{
        //    ContentDialog errorDialog = new ContentDialog
        //    {
        //        Title = "Error con la Base de Datos",
        //        Content = "Ups! Ha ocurrido un error",
        //        PrimaryButtonText = "Actualizar Pagina",
        //        CloseButtonText = "Cerrar Aplicacion"
        //    };

        //    ContentDialogResult result = await errorDialog.ShowAsync();

        //    if (result == ContentDialogResult.Primary)
        //    {
        //        MainPage.GetCurrent().SetNavigationToIndex(0);
        //    }
        //    else
        //    {
        //        Application.Current.Exit();
        //    }
        //}

        #endregion

        #region Eventos

        //public void recargarPagina(object sender, RoutedEventArgs e)
        //{
        //    MainPage.GetCurrent().SetNavigationToIndex(0);
        //}
        #endregion
    }
}
