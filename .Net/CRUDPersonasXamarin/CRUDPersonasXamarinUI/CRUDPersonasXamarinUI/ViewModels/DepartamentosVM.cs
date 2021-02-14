using CRUDPersonasXamarin_BL.Listados;
using CRUDPersonasXamarin_Entidades;
using CRUDPersonasXamarinUI.Utilidades;
using CRUDPersonasXamarinUI.ViewModels.Utilidades;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Text;
using System.Threading.Tasks;
using Xamarin.Forms;

namespace CRUDPersonasXamarinUI.ViewModels
{
    public class DepartamentosVM : clsVMBase, IAsyncInitialization
    {
        #region Atributos
        private String buscar;
        private clsDepartamento departamentoSeleccionado;
        private List<clsDepartamento> listadoDepartamentosCompleto;
        #endregion

        #region Propiedades
        public INavigation Navigation { get; set; }
        public Task Initialization { get; private set; }
        public String TextoBuscado { get; set; }
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
                BuscarCommand_Executed();

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
            EliminarCommand = new DelegateCommand(EliminarCommand_Executed, EliminarCommand_CanExecute);
            CrearCommand = new DelegateCommand(CrearCommand_Executed);
            Initialization = InitializeAsync();

        }
        #endregion

        #region Métodos

        public async Task InitializeAsync()
        {
            clsListadoDepartamentosBL clsListadoDepartamentosBL = new clsListadoDepartamentosBL();
            listadoDepartamentosCompleto = await clsListadoDepartamentosBL.listadoDepartamentosBL();
            ListadoDepartamentosBuscado = new ObservableCollection<clsDepartamento>(listadoDepartamentosCompleto);
            NotifyPropertyChanged("ListadoDepartamentosBuscado");
        }

        //Eliminar
        private async void EliminarCommand_Executed()
        {
            /*clsManejadoraPersonasBL clsManejadoraPersonasBL = new clsManejadoraPersonasBL();

            bool answer = await Application.Current.MainPage.DisplayAlert("Eliminar Persona", "Desea eliminar a la persona?", "Si", "No");
            if (answer)
            {
                await clsManejadoraPersonasBL.eliminarPersonaBLAsync(personaSeleccionada.ID);

                await Navigation.PushAsync(new ListadoPersonas());
            }*/

        }

        private bool EliminarCommand_CanExecute()
        {
            bool canExecute = true;

            if (departamentoSeleccionado == null)
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
            //await Navigation.PushAsync(new PersonasDetail(new clsPersona()));
        }

        #endregion
    }
}
