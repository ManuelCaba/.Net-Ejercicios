using _01_HolaMundoWF_Entities;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace _01_HolaMundoWP_UI
{
    public partial class index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSaludar_Click(object sender, EventArgs e)
        {
            clsPersona persona = new clsPersona();
            String nombre = txbNombre.Text;

            if (!String.IsNullOrEmpty(nombre))
            {
                lblSaludar.ForeColor = Color.Black;
                persona.nombre = nombre;
                lblSaludar.Text = "Hola "+persona.nombre;
            }
            else
            {
                lblSaludar.Text = "Escriba un nombre";
                lblSaludar.ForeColor = Color.Red;
            }
        }
    }
}