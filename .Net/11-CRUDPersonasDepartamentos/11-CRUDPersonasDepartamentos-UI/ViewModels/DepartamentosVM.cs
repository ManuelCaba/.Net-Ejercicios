using _11_CRUDPersonasDepartamentos_BL.Listados;
using _11_CRUDPersonasDepartamentos_BL.Manejadoras;
using _11_CRUDPersonasDepartamentos_BL.Excepciones;
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
    public class DepartamentosVM : Utilidades.clsVMBase
    {
        #region Atributos
        private String buscar;
        private clsDepartamento departamentoSeleccionado;
        private clsDepartamento departamentoInmutable;
        private List<clsDepartamento> listadoDepartamentosCompleto;
        #endregion

        #region Propiedades
        public String TextoBuscado { get; set; }
        public DelegateCommand BuscarCommand { get; }
        public DelegateCommand GuardarCommand { get; }
        public DelegateCommand EliminarCommand { get; }
        public DelegateCommand CrearCommand { get; }
        public ObservableCollection<clsDepartamento> ListadoDepartamentosBuscado { get; set; }
        public clsDepartamento DepartamentoSeleccionado
        {
            get
            {
                return departamentoSeleccionado;
            }

            set
            {
                if (departamentoSeleccionado != value && value != null)
                {
                    departamentoSeleccionado = value;
                    departamentoInmutable = new clsDepartamento(value);
                    NotifyPropertyChanged("DepartamentoSeleccionado");
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
                    ListadoDepartamentosBuscado = new ObservableCollection<clsDepartamento>(listadoDepartamentosCompleto);
                    NotifyPropertyChanged("ListadoDepartamentosBuscado");
                }
            }
        }
        #endregion

        #region Constructores
        public DepartamentosVM()
        {
            BuscarCommand = new DelegateCommand(BuscarCommand_Executed, BuscarCommand_CanExecute);
            EliminarCommand = new DelegateCommand(EliminarCommand_Executed, EliminarCommand_CanExecute);
            CrearCommand = new DelegateCommand(CrearCommand_Executed);
            GuardarCommand = new DelegateCommand(GuardarCommand_Executed, GuardarCommand_CanExecute);
            clsListadoDepartamentosBL listadoPersonas = new clsListadoDepartamentosBL();
            //Rellenamos el listado de departamentos porque hace falta nada mas entrar en la página
            try
            {
                listadoDepartamentosCompleto = listadoPersonas.listadoDepartamentosBL();
                ListadoDepartamentosBuscado = new ObservableCollection<clsDepartamento>(listadoDepartamentosCompleto);
            }
            catch (SqlException e)
            {
                dialogErrorAsync();
            }

        }
        #endregion

        #region Métodos

        //Eliminar
        private async void EliminarCommand_Executed()
        {
            clsManejadoraDepartamentosBL clsManejadoraDepartamentos = new clsManejadoraDepartamentosBL();

            ContentDialog deleteFileDialog = new ContentDialog
            {
                Title = "Desea borrar el departamento seleccionado?",
                Content = "Si lo borras, no podras recuperarlo. Quieres borrarlo?",
                PrimaryButtonText = "Borrar",
                CloseButtonText = "Cancelar"
            };

            ContentDialogResult result = await deleteFileDialog.ShowAsync();

            // Borrar la persona si el usuario pulsa el botón primario.
            /// En otro lugar, nada.
            if (result == ContentDialogResult.Primary)
            {
                try
                {
                    if (clsManejadoraDepartamentos.eliminarDepartamentoBL(departamentoInmutable.ID) > 0)
                    {
                        listadoDepartamentosCompleto.Remove(departamentoSeleccionado);
                        ListadoDepartamentosBuscado.Remove(departamentoSeleccionado);

                        departamentoSeleccionado = null;

                        NotifyPropertyChanged("DepartamentoSeleccionado");

                        departamentoInmutable = null;
                    }
                }
                catch (SqlException)
                {
                    dialogErrorAsync();
                }
                catch(DepartmentContainsPeopleException)
                {
                    ContentDialog errorDelete = new ContentDialog
                    {
                        Title = "Error al borrar el departamento",
                        Content = "Este departamento contiene personas",
                        PrimaryButtonText = "Aceptar",
                    };

                    await errorDelete.ShowAsync();
                }

            }

        }

        private bool EliminarCommand_CanExecute()
        {
            bool canExecute = true;

            if (departamentoInmutable == null)
            {
                canExecute = false;
            }

            return canExecute;
        }

        //Buscar
        private void BuscarCommand_Executed()
        {
            ListadoDepartamentosBuscado.Clear();

            foreach (clsDepartamento departamento in listadoDepartamentosCompleto)
            {

                if (departamento.Nombre.ToLower().Contains(buscar.ToLower()))
                {
                    ListadoDepartamentosBuscado.Add(departamento);
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
            departamentoSeleccionado = null;

            NotifyPropertyChanged("DepartamentoSeleccionado");

            departamentoSeleccionado = new clsDepartamento();

            departamentoInmutable = null;

            departamentoSeleccionado.ID = 0;
            departamentoSeleccionado.Nombre = "";

            NotifyPropertyChanged("DepartamentoSeleccionado");
        }

        //Guardar
        private bool GuardarCommand_CanExecute()
        {
            bool canExecute = false;

            if (departamentoSeleccionado != null)
            {
                if (!String.IsNullOrEmpty(departamentoSeleccionado.Nombre))
                {
                    if (departamentoInmutable == null)
                    {
                        canExecute = true;
                    }
                    else
                    {
                        //TODO Foto

                        if (!departamentoInmutable.Nombre.Equals(departamentoSeleccionado.Nombre))
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
            clsManejadoraDepartamentosBL clsManejadoraDepartamentos = new clsManejadoraDepartamentosBL();
            clsListadoDepartamentosBL listadoDepartamentos = new clsListadoDepartamentosBL();

            try
            {
                if (DepartamentoSeleccionado.ID < 1)
                {
                    clsManejadoraDepartamentos.crearDepartamentoBL(departamentoSeleccionado);
                }
                else
                {
                    clsManejadoraDepartamentos.editarDepartamentoBL(departamentoSeleccionado);
                }

                departamentoInmutable = new clsDepartamento(departamentoSeleccionado);

                GuardarCommand.RaiseCanExecuteChanged();

                listadoDepartamentosCompleto = listadoDepartamentos.listadoDepartamentosBL();
                ListadoDepartamentosBuscado = new ObservableCollection<clsDepartamento>(listadoDepartamentosCompleto);

                NotifyPropertyChanged("ListadoDepartamentosBuscado");
            }
            catch (SqlException e)
            {
                //dialogErrorAsync();
            }
        }

        //Dialog
        private async Task dialogErrorAsync()
        {
            ContentDialog errorDialog = new ContentDialog
            {
                Title = "Error con la Base de Datos",
                Content = "Ups! Ha ocurrido un error",
                PrimaryButtonText = "Actualizar Pagina",
                CloseButtonText = "Cerrar Aplicacion"
            };

            ContentDialogResult result = await errorDialog.ShowAsync();

            if (result == ContentDialogResult.Primary)
            {
                MainPage.GetCurrent().SetNavigationToIndex(1);
            }
            else
            {
                Application.Current.Exit();
            }
        }

        #endregion

        #region Eventos
        public void cambiarGuardarCommand(object sender, RoutedEventArgs e)
        {
            GuardarCommand.RaiseCanExecuteChanged();
        }

        public void recargarPagina(object sender, RoutedEventArgs e)
        {
            MainPage.GetCurrent().SetNavigationToIndex(1);
        }
        #endregion
    }
}
