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
        private clsPersona personaInmutable;
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
                if(personaSeleccionada != value && value != null)
                {
                    personaSeleccionada = value;
                    personaInmutable = new clsPersona(value);
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
            GuardarCommand = new DelegateCommand(GuardarCommand_Executed, GuardarCommand_CanExecute);
            clsListadoPersonasBL listadoPersonas = new clsListadoPersonasBL();
            clsListadoDepartamentosBL listadoDepartamentos = new clsListadoDepartamentosBL();
            //Rellenamos el listado de personas porque hace falta nada mas entrar en la página
            try
            {
                listadoPersonasCompleto = listadoPersonas.listadoPersonasBL();
                ListadoPersonasBuscadas = new ObservableCollection<clsPersona>(listadoPersonasCompleto);
                ListadoDepartamentos = new ObservableCollection<clsDepartamento>(listadoDepartamentos.listadoDepartamentosBL());
            }
            catch(SqlException e)
            {
                //contentdialog
            }

        }
        #endregion

        #region Métodos

        //Eliminar
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
                listadoPersonasCompleto.Remove(personaInmutable);
                ListadoPersonasBuscadas.Remove(personaInmutable);
            }

            PersonaSeleccionada = null;
            personaInmutable = null;

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

            personaInmutable = null;

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

        //Guardar
        private bool GuardarCommand_CanExecute()
        {
            bool canExecute = false;

            if(personaSeleccionada != null)
            {
                if(!String.IsNullOrEmpty(personaSeleccionada.Nombre))
                {
                    if(personaInmutable == null)
                    {
                        canExecute = true;
                    }
                    else
                    {
                        //TODO Foto

                        if (!personaInmutable.Nombre.Equals(personaSeleccionada.Nombre) ||
                            !personaInmutable.Apellidos.Equals(personaSeleccionada.Apellidos) ||
                            !personaInmutable.FechaNacimiento.Equals(personaSeleccionada.FechaNacimiento) ||
                            !personaInmutable.Foto.Equals(personaSeleccionada.Foto) ||
                            !personaInmutable.Direccion.Equals(personaSeleccionada.Direccion) ||
                            !personaInmutable.Telefono.Equals(personaSeleccionada.Telefono) ||
                            !personaInmutable.IDDepartamento.Equals(personaSeleccionada.IDDepartamento))
                        {
                            canExecute = true;
                        }
                    }
                }
            }            

            return canExecute;
        }

        //Guardar
        private void GuardarCommand_Executed()
        {
            if(PersonaSeleccionada.ID < 1)
            {
                //Crear Nuevo
            }
            else
            {
                //Actualizar
            }
        }
        #endregion

        #region Eventos
        public void cambiarGuardarCommand(object sender, RoutedEventArgs e)
        {
            GuardarCommand.RaiseCanExecuteChanged();
        }
        #endregion
    }
}
