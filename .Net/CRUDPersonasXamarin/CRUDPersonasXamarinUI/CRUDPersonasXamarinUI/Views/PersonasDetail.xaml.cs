using CRUDPersonasXamarin_Entidades;
using CRUDPersonasXamarinUI.ViewModels;
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
    public partial class PersonasDetail : ContentPage
    {
        public PersonasDetail(clsPersona persona)
        {
            InitializeComponent();
            ((DetallesVM)BindingContext).Persona = persona;
            ((DetallesVM)this.BindingContext).Navigation = Navigation;
        }

        private void OnPickPhotoButtonClicked(object sender, EventArgs e)
        {
            ((DetallesVM)BindingContext).OnPickPhotoButtonClicked(sender, e);
        }
    }
}