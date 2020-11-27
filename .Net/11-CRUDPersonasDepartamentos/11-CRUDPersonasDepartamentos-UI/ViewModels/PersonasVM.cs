using _10_CRUDPersonas_BL.Listados;
using _11_CRUDPersonasDepartamentos_BL.Listados;
using _11_CRUDPersonasDepartamentos_Entidades;
using _11_CRUDPersonasDepartamentos_UI.Utilidades;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Windows.UI.Xaml;
using Windows.UI.Xaml.Controls;

namespace _11_CRUDPersonasDepartamentos_UI.ViewModels
{
    public class PersonasVM : Utilidades.clsVMBase
    {
        #region Atributos
        private String buscar;
        private clsPersona personaSeleccionada;
        private List<clsPersona> listadoPersonasCompleto;
        #endregion

        #region Propiedades
        public String TextoBuscado { get; set; }
        public DelegateCommand BuscarCommand { get; }
        public DelegateCommand GuardarCommand { get; }
        public DelegateCommand EliminarCommand { get; }
        public DelegateCommand CrearCommand { get; }
        public ObservableCollection<clsPersona> ListadoPersonasBuscadas { get; set; }
        public ObservableCollection<clsDepartamento> ListadoDepartamentos { get; set; }
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
            //EliminarCommand = new DelegateCommand(EliminarCommand_ExecutedAsync, EliminarCommand_CanExecute);
            CrearCommand = new DelegateCommand(CrearCommand_Executed);
            //GuardarCommand = new DelegateCommand(GuardarCommand_ExecutedAsync, GuardarCommand_CanExecute);
            clsListadoPersonas listadoPersonas = new clsListadoPersonas();
            clsListadoDepartamentos listadoDepartamentos = new clsListadoDepartamentos();
            //Rellenamos el listado de personas porque hace falta nada mas entrar en la página
            try
            {
                listadoPersonasCompleto = listadoPersonas.listadoPersonas();
                ListadoPersonasBuscadas = new ObservableCollection<clsPersona>(listadoPersonasCompleto);
                ListadoDepartamentos = new ObservableCollection<clsDepartamento>(listadoDepartamentos.listadoDepartamentos());
            }
            catch(SqlException e)
            {
                //contentdialog
            }

        }
        #endregion

        #region Métodos
        public void eliminarPersona(Object sender, RoutedEventArgs e)
        {
            if (personaSeleccionada != null)
            {
                listadoPersonasCompleto.Remove(PersonaSeleccionada);
            }
        }

        private async void EliminarCommand_Executed()
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
                listadoPersonasCompleto.Remove(PersonaSeleccionada);
                ListadoPersonasBuscadas.Remove(PersonaSeleccionada);
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

        private void CrearCommand_Executed()
        {
            personaSeleccionada = new clsPersona();

            NotifyPropertyChanged("PersonaSeleccionada");
        }
        #endregion
    }
}
