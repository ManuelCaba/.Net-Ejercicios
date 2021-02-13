using CRUDPersonasXamarin_BL.Listados;
using CRUDPersonasXamarin_Entidades;
using CRUDPersonasXamarinUI.ViewModels.Utilidades;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.IO;
using System.Text;
using System.Threading.Tasks;
using Xamarin.Forms;

namespace CRUDPersonasXamarinUI.ViewModels
{
    public class DetallesVM : Utilidades.clsVMBase, IAsyncInitialization
    {
        #region Atributos
        private clsPersona persona;
        #endregion

        #region Propiedades
        public Task Initialization { get; private set; }
        public clsDepartamento DepartamentoSeleccionado { get; set; }
        public ObservableCollection<clsDepartamento> ListadoDepartamentos { get; private set; }
        public clsPersona Persona { get { return persona; } set { persona = value; NotifyPropertyChanged("Persona"); } }
        #endregion

        #region Constructores
        public DetallesVM()
        {
            persona = new clsPersona();
            Initialization = InitializeAsync();
        }

        #endregion

        #region Métodos
        public async Task InitializeAsync()
        {
            clsListadoDepartamentosBL clsListadoDepartamentosBL = new clsListadoDepartamentosBL();
            ListadoDepartamentos = new ObservableCollection<clsDepartamento>(await clsListadoDepartamentosBL.listadoDepartamentosBL());
            NotifyPropertyChanged("ListadoDepartamentos");
            departamentoSeleccionado();
        }
        /// <summary>
        /// Método que inicializa el departamento de la persona para luego
        /// ser bindeada al elemento seleccionado del select de la vista
        /// </summary>
        public void departamentoSeleccionado()
        {
            bool encontrado = false;
            for(int i = 0; i < ListadoDepartamentos.Count && encontrado == false; i++)
            {
                if(ListadoDepartamentos[i].ID == persona.IDDepartamento)
                {
                    DepartamentoSeleccionado = ListadoDepartamentos[i];
                    NotifyPropertyChanged("DepartamentoSeleccionado");
                    encontrado = true;
                }
            }
        }

        public async void OnPickPhotoButtonClicked(object sender, EventArgs e)
        {
            (sender as Button).IsEnabled = false;

            Stream stream = await DependencyService.Get<IPhotoPickerService>().GetImageStreamAsync();
            if (stream != null)
            {
                MemoryStream ms = new MemoryStream();
                stream.CopyTo(ms);
                persona.Foto = ms.ToArray();
            }

            NotifyPropertyChanged("Persona");

            (sender as Button).IsEnabled = true;
        }
        #endregion
    }
}
