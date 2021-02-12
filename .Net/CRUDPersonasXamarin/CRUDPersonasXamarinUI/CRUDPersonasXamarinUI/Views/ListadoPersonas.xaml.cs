﻿using CRUDPersonasXamarinUI.ViewModels;
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

            ((PersonasVM)this.BindingContext).Navigation = Navigation;

            ListView = ListadoPersonasBuscadas;
        }
    }
}