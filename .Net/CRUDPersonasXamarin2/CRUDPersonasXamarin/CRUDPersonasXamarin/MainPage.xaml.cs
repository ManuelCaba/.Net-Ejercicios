using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Xamarin.Forms;

namespace CRUDPersonasXamarin
{
    public partial class MainPage : MasterDetailPage
    {
        public MainPage()
        {
            InitializeComponent();
            Detail = new NavigationPage(this);
            IsPresented = false;
        }
        private void Button_Clicked(object sender, EventArgs e)
        {
            Detail = new NavigationPage(this);
            IsPresented = false;
        }
        private void Button_Clicked2(object sender, EventArgs e)
        {
            Detail = new NavigationPage(this);
            IsPresented = false;
        }

        private void Button_Clicked3(object sender, EventArgs e)
        {
            Detail = new NavigationPage(this);
            IsPresented = false;
        }
        private void Button_Clickded4(object sender, EventArgs e)
        {
            Detail = new NavigationPage(this);
            IsPresented = false;
        }
    }
}

