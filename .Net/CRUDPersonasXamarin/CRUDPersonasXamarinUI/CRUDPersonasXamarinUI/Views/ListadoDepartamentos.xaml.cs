using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using Xamarin.Forms;
using Xamarin.Forms.Xaml;

namespace CRUDPersonasXamarinUI.Views
{
    [XamlCompilation(XamlCompilationOptions.Compile)]
    public partial class ListadoDepartamentos : ContentPage
    {
        public ListadoDepartamentos()
        {
            InitializeComponent();
            DisplayAlert("Construccion", "Pagina en construccion", "Aceptar");
        }
    }
}