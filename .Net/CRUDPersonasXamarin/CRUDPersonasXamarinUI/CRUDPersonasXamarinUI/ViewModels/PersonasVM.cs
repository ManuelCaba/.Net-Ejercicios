using CRUDPersonasXamarin_BL.Manejadoras;
using CRUDPersonasXamarin_BL.Listados;
using CRUDPersonasXamarin_Entidades;
using CRUDPersonasXamarinUI.Utilidades;
using CRUDPersonasXamarinUI.ViewModels.Utilidades;
using CRUDPersonasXamarinUI.Views;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Threading.Tasks;
using Windows.UI.Xaml.Controls;
using Xamarin.Forms;

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
        public INavigation Navigation { get; set; }
        public Task Initialization { get; private set; }
        public String TextoBuscado { get; set; }
        public DelegateCommand BuscarCommand { get; }
        public DelegateCommand EliminarCommand { get; }
        public DelegateCommand EditarCommand { get; }
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
                if (personaSeleccionada != value && value != null)
                {
                    personaSeleccionada = value;
                    NotifyPropertyChanged("PersonaSeleccionada");
                    EliminarCommand.RaiseCanExecuteChanged();
                    EditarCommand.RaiseCanExecuteChanged();
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
                BuscarCommand_Executed();

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
            EliminarCommand = new DelegateCommand(EliminarCommand_Executed, EliminarCommand_CanExecute);
            EditarCommand = new DelegateCommand(EditarCommand_Executed, EditarCommand_CanExecute);
            CrearCommand = new DelegateCommand(CrearCommand_ExecutedAsync);
            Initialization = InitializeAsync();

        }
        #endregion

        #region Métodos

        //Eliminar
        public async Task InitializeAsync()
        {
            try
            {
                clsListadoPersonasBL clsListadoPersonasBL = new clsListadoPersonasBL();
                listadoPersonasCompleto = await clsListadoPersonasBL.listadoPersonasBLAsync();
                ListadoPersonasBuscadas = new ObservableCollection<clsPersona>(listadoPersonasCompleto);
                NotifyPropertyChanged("ListadoPersonasBuscadas");
            }
            catch(Exception e)
            {
                error();
            }

        }
        private async void EliminarCommand_Executed()
        {
            try
            {
                clsManejadoraPersonasBL clsManejadoraPersonasBL = new clsManejadoraPersonasBL();

                bool answer = await Application.Current.MainPage.DisplayAlert("Eliminar Persona", "Desea eliminar a la persona?", "Si", "No");
                if (answer)
                {
                    await clsManejadoraPersonasBL.eliminarPersonaBLAsync(personaSeleccionada.ID);

                    await Navigation.PushAsync(new ListadoPersonas());
                }
            }
            catch(Exception ex)
            {
                error();
            }

        }

        private bool EliminarCommand_CanExecute()
        {
            bool canExecute = true;

            if (personaSeleccionada == null)
            {
                canExecute = false;
            }

            return canExecute;
        }

        //Editar
        private async void EditarCommand_Executed()
        {
            await Navigation.PushAsync(new PersonasDetail(personaSeleccionada));
        }

        private bool EditarCommand_CanExecute()
        {
            bool canExecute = true;

            if (personaSeleccionada == null)
            {
                canExecute = false;
            }

            return canExecute;
        }

        //Buscar
        private void BuscarCommand_Executed()
        {
            ListadoPersonasBuscadas.Clear();

            foreach (clsPersona persona in listadoPersonasCompleto)
            {
                String nombreCompleto = persona.Nombre + " " + persona.Apellidos;

                if (nombreCompleto.ToLower().Contains(buscar.ToLower()))
                {
                    ListadoPersonasBuscadas.Add(persona);
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
        private async void CrearCommand_ExecutedAsync()
        {
            await Navigation.PushAsync(new PersonasDetail(new clsPersona()));
        }

        private async void error()
        {
            await Application.Current.MainPage.DisplayAlert("Error", "Ha ocurrido un error", "Aceptar");
        }

        #endregion
    }
}
