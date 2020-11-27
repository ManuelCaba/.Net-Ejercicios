using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace _11_CRUDPersonasDepartamentos_UI.ViewModels.Utilidades
{
    public abstract class clsVMBase : INotifyPropertyChanged
    {
        public event PropertyChangedEventHandler PropertyChanged;

        protected void NotifyPropertyChanged(String property = null)
        {
             PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(property));   
        }
    }
}
