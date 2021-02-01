using _15_Xamarin_02.ViewModels;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Xamarin.Forms;

namespace _15_Xamarin_02
{
    public partial class MainPage : ContentPage
    {
        public MainPage()
        {
            InitializeComponent();
        }

        private void ActualizarSaludar(object sender, TextChangedEventArgs e)
        {
            ((MainPageVM)BindingContext).ActualizarSaludar(sender, e);
        }
    }
}
