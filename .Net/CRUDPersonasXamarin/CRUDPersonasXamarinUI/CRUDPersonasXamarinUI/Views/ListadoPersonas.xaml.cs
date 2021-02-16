using CRUDPersonasXamarinUI.ViewModels;
using Plugin.DeviceInfo;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Text;
using System.Threading.Tasks;

using Xamarin.Forms;
using Xamarin.Forms.Xaml;

namespace CRUDPersonasXamarinUI.Views
{
    [XamlCompilation(XamlCompilationOptions.Compile)]
    public partial class ListadoPersonas : ContentPage
    {
        public ListView ListView;

        public ListadoPersonas()
        {
            InitializeComponent();

            if (Device.RuntimePlatform == Device.iOS || Device.RuntimePlatform == Device.Android)
            {
                stkListado.Children.RemoveAt(1);
            }

            ((PersonasVM)this.BindingContext).Navigation = Navigation;

            ListView = ListadoPersonasBuscadas;
        }
    }
}