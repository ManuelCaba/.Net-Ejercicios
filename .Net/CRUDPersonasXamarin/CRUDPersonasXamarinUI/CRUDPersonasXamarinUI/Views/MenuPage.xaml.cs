﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using Xamarin.Forms;
using Xamarin.Forms.Xaml;

namespace CRUDPersonasXamarinUI.Views
{
    [XamlCompilation(XamlCompilationOptions.Compile)]
    public partial class MenuPage : MasterDetailPage
    {
        public MenuPage()
        {
            InitializeComponent();
            Detail = new NavigationPage(new ListadoPersonas());
            IsPresented = false;
        }

        private async void navegarListadoPersonas(object sender, EventArgs e)
        {
            await Detail.Navigation.PushAsync(new ListadoPersonas());
            IsPresented = false;
        }
        private async void navegarListadoDepartamentos(object sender, EventArgs e)
        {
            await Detail.Navigation.PushAsync(new ListadoDepartamentos());
            IsPresented = false;
        }
    }
}
