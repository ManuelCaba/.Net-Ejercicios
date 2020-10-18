using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Runtime.InteropServices.WindowsRuntime;
using Windows.Foundation;
using Windows.Foundation.Collections;
using Windows.UI.Xaml;
using Windows.UI.Xaml.Controls;
using Windows.UI.Xaml.Controls.Primitives;
using Windows.UI.Xaml.Data;
using Windows.UI.Xaml.Input;
using Windows.UI.Xaml.Media;
using Windows.UI.Xaml.Navigation;

// La plantilla de elemento Página en blanco está documentada en https://go.microsoft.com/fwlink/?LinkId=402352&clcid=0xc0a

namespace _08_LayoutsUWP_06
{
    /// <summary>
    /// Página vacía que se puede usar de forma independiente o a la que se puede navegar dentro de un objeto Frame.
    /// </summary>
    public sealed partial class MainPage : Page
    {

        public MainPage()
        {
            this.InitializeComponent();           
        }

        /// <summary>
        /// Borrará todos los campos del formulario
        /// </summary>
        public void nuevoFormulario(object sender, RoutedEventArgs e)
        {
            txbNombre.Text = "";
            txbApellidos.Text = "";
            txbFecha.Text = "";
        }

        /// <summary>
        /// Validará todos los campos del formulario
        /// </summary>
        public void guardarFormulario(object sender, RoutedEventArgs e)
        {
            if(validarCampoFecha() & validarCampoNombre() & validarCampoApellidos())
            {
                txkFormularioGuardado.Text = "Se ha guardado correctamente";
            }
            else
            {
                txkFormularioGuardado.Text = "";
            }
        }

        /// <summary>
        /// Valida si el campo de nombre esta vacío, en casa de estarlo
        /// mandará un mensaje de error. Se mandará un boolean, true para
        /// campo lleno y false para campo vacío.
        /// </summary>
        public bool validarCampoNombre()
        {
            bool campoLleno = true;

            if(String.IsNullOrEmpty(txbNombre.Text))
            {
                txkErrorNombre.Text = "El nombre no puede estar vacío";
                campoLleno = false;
            }
            else
            {
                txkErrorNombre.Text = "";
            }

            return campoLleno;
        }

        /// <summary>
        /// Valida si el campo de fecha esta vacío, en casa de estarlo
        /// mandará un mensaje de error. Se mandará un boolean, true para
        /// campo lleno y false para campo vacío.
        /// </summary>
        public bool validarCampoFecha()
        {
            bool campoLleno = true;

            if (String.IsNullOrEmpty(txbFecha.Text))
            {
                txkErrorFecha.Text = "La fecha no puede estar vacía";
                campoLleno = false;
            }
            else
            {
                txkErrorFecha.Text = "";
            }

            return campoLleno;
        }

        /// <summary>
        /// Valida si el campo de apellidos esta vacío, en casa de estarlo
        /// mandará un mensaje de error. Se mandará un boolean, true para
        /// campo lleno y false para campo vacío.
        /// </summary>
        public bool validarCampoApellidos()
        {
            bool campoLleno = true;

            if (String.IsNullOrEmpty(txbApellidos.Text))
            {
                txkErrorApellidos.Text = "Los apellidos no pueden estar vacíos";
                campoLleno = false;
            }
            else
            {
                txkErrorApellidos.Text = "";
            }

            return campoLleno;
        }


        /// <summary>
        /// Abre un cuadro de diálogo para confirmar si quiere borrar el
        /// formulario, en caso positivo se borrará
        /// </summary>
        public async void borrarFormulario(object sender, RoutedEventArgs e)
        {
            ContentDialog deleteFileDialog = new ContentDialog
            {
                Title = "Desea boorar el formulario?",
                Content = "Si lo borras, no podras recuperarlo. Quieres borrarlo?",
                PrimaryButtonText = "Borrar",
                CloseButtonText = "Cancelar"
            };

            ContentDialogResult result = await deleteFileDialog.ShowAsync();

            // Borrar el formulario si el usuario pulsa el botón primario.
            /// En otro lugar, nada.
            if (result == ContentDialogResult.Primary)
            {
                txbNombre.Text = "";
                txbApellidos.Text = "";
                txbFecha.Text = "";
            }
        }
    }
}
