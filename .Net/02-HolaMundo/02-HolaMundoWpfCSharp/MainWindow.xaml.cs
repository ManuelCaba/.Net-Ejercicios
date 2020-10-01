using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace _02_HolaMundoWpfCSharp
{
    /// <summary>
    /// Lógica de interacción para MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
        }

        /// <summary>
        /// Función que al pulsar 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void Button_Click(object sender, RoutedEventArgs e)
        {
            //Instanciamos objeto de tipo persona
            clsPersona persona = new clsPersona();

            persona.Nombre = txbNombre.Text;

            //TODO Validar que no esté vacío el campo de texto
            if (!String.IsNullOrEmpty(persona.Nombre))
            {
                lblErrorNombre.Content = "";
                MessageBox.Show($"Hola {persona.Nombre}");
            }  
            else
            {
                lblErrorNombre.Content = "El nombre no puede estar vacío";
            }
        }

    }
}
