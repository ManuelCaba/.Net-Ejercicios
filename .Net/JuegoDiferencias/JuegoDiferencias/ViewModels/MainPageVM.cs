using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Windows.UI.Xaml.Input;
using Windows.UI.Xaml.Shapes;

namespace JuegoDiferencias.ViewModels
{
    public class MainPageVM : clsVMBase
    {
        private int contadorAciertos;
        public int ContadorAcierto { get { return contadorAciertos; } }

        public MainPageVM()
        {
            contadorAciertos = 0;
        }

        /// <summary>
        /// Evento para cambiar la opacidad de una elipse
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        public void ChangeOpacity(object sender, TappedRoutedEventArgs e)
        {
            Ellipse elipse = (Ellipse)sender;
            if(elipse.Opacity == 0)
            {
                contadorAciertos++;
                NotifyPropertyChanged("ContadorAcierto");
            }
            elipse.Opacity = 100;
        }
    }
}
