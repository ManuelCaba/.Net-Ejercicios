using ExamenUWPEntidades;
using System;
using System.Collections.Generic;
using ExamenUWPBL.Listados;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Collections.ObjectModel;
using ExamenUWPUI.ViewModels.Utilidades;
using ExamenUWPUI.Utilidades;

namespace ExamenUWPUI.ViewModels
{
    public class MainPageVM : clsVMBase
    {
        #region Atributos
        private clsAula aulaSeleccionada;
        #endregion

        #region Propiedades
        public ObservableCollection<clsAula> ListadoCompletoAulas { get; set; }
        public clsAula AulaSeleccionada { 
            get { 
                return aulaSeleccionada; 
            } 
            set { 
                aulaSeleccionada = value; 
                BuscarCommand.RaiseCanExecuteChanged(); 
            } 
        }
        public DateTime SelectedDate { get; set; }
        public DelegateCommand BuscarCommand { get; }
        public clsTemperatura Temperatura { get; set; }
        #endregion

        #region Constructores
        public MainPageVM()
        {
            clsListadoAulasBL clsListadoAulasBL = new clsListadoAulasBL();
            ListadoCompletoAulas = new ObservableCollection<clsAula>(clsListadoAulasBL.listadoAulasBL());
            BuscarCommand = new DelegateCommand(BuscarCommand_Executed, BuscarCommand_CanExecute);
            Temperatura = new clsTemperatura();
        }

        private bool BuscarCommand_CanExecute()
        {
            
            bool canExecute = false;

            if(AulaSeleccionada != null)
            {
                canExecute = true;
            }

            return canExecute;
        }

        private void BuscarCommand_Executed()
        {
            clsListadoTemperaturasBL clsListadoTemperaturasBL = new clsListadoTemperaturasBL();
            Temperatura = clsListadoTemperaturasBL.temperaturasPorAulaYFecha(aulaSeleccionada.IDAula, SelectedDate);
            NotifyPropertyChanged("Temperatura");
        }
        #endregion
    }
}
