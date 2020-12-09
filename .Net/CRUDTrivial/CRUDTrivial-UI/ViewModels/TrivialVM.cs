using CRUDTrivial_BL.Listados;
using CRUDTrivial_Entidades;
using CRUDTrivial_UI.ViewModels.Utilidades;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Windows.UI.Xaml;
using Windows.UI.Xaml.Controls;

namespace CRUDTrivial_UI.ViewModels
{
    public class TrivialVM : clsVMBase
    {
        #region Atributos
        private List<clsActor> listadoCompletoActores;
        private List<clsActor> listadoActoresPartida;
        private ObservableCollection<clsActor> listadoActoresJugadaActual;
        private clsActor actorActual;
        private clsActor respuestaSeleccionada;
        private int contadorPartidas;
        private int respuestasAcertadas;
        private int respuestasIncorrectas;
        private String uriFoto;
        private String respuesta;
        #endregion

        #region Propiedades
        public List<clsActor> ListadoActoresPartida { get { return listadoActoresPartida; } }
        public ObservableCollection<clsActor> ListadoActoresJugadaActual { get { return listadoActoresJugadaActual; } }
        public clsActor ActorActual { get { return actorActual; } }
        public int RespuestasAcertadas { get { return respuestasAcertadas; } }
        public int RespuestasIncorrectas { get { return respuestasIncorrectas; } }
        public String URIFoto { get { return uriFoto; } }
        public int ContadorPartidas { get { return contadorPartidas; } }
        public clsActor RespuestaSeleccionada 
        { 
            get 
            {
                return respuestaSeleccionada; 
            }
            set
            {
                if(value != null)
                {
                    respuestaSeleccionada = value;
                    this.comprobarRespuesta();
                }
            }
        }
        #endregion

        #region Constructores
        public TrivialVM()
        {
            clsListadosActoresBL clsListadosActores = new clsListadosActoresBL();
            Random miAleatorio = new Random();

            respuestasAcertadas = 0;
            respuestasIncorrectas = 0;
            contadorPartidas = 1;
            listadoCompletoActores = clsListadosActores.listadoActoresBL();
            listadoActoresJugadaActual = new ObservableCollection<clsActor>();
            listadoActoresPartida = new List<clsActor>();
            this.generarRespuestas();
            actorActual = listadoActoresJugadaActual[miAleatorio.Next(0, 4)];
            uriFoto = "ms-appx://CRUDTrivial/Assets/Fotos/" + actorActual.ID + ".jpg";
            listadoActoresPartida.Add(actorActual);
        }
        #endregion

        #region Métodos
        /// <summary>
        /// Método que genera las posibles apuestas de una partida teniendo en cuenta que la solución de
        /// cualquier jugada anterior no se encuentra
        /// </summary>
        private void generarRespuestas()
        {
            List<int> randoms = new List<int>();
            int numeroAleatorio = 0;
            int contador = 0;
            clsActor actor;

            Random miAleatorio = new Random();

            while(contador < 4)
            {
                numeroAleatorio = miAleatorio.Next(0, 20);

                if (!randoms.Contains(numeroAleatorio))
                {
                    randoms.Add(numeroAleatorio);

                    actor = listadoCompletoActores[numeroAleatorio];

                    if(!listadoActoresPartida.Contains(actor))
                    {
                        listadoActoresJugadaActual.Add(actor);

                        contador++;
                    }
                }
            }

        }

        /// <summary>
        /// Método que comprueba la opción elegida en el Trivial
        /// </summary>
        private async Task comprobarRespuesta()
        {
            Random miAleatorio = new Random();

            if(contadorPartidas <= 10)
            {
                if (actorActual.Equals(respuestaSeleccionada))
                {
                    respuestasAcertadas++;
                    respuesta = "Has acertado";
                    NotifyPropertyChanged("RespuestasAcertadas");
                }
                else
                {
                    respuestasIncorrectas++;
                    respuesta = "Has fallado";
                    NotifyPropertyChanged("RespuestasIncorrectas");
                }

                ContentDialog respuestaUsuario = new ContentDialog
                {
                    Title = "Opción elegida",
                    Content = respuesta,
                    PrimaryButtonText = "Continuar",
                };

                await respuestaUsuario.ShowAsync();

                listadoActoresJugadaActual.Clear();
                this.generarRespuestas();
                actorActual = listadoActoresJugadaActual[miAleatorio.Next(0, 4)];
                uriFoto = "ms-appx://CRUDTrivial/Assets/Fotos/" + actorActual.ID + ".jpg";
                NotifyPropertyChanged("URIFoto");
                listadoActoresPartida.Add(actorActual);
                contadorPartidas++;
                NotifyPropertyChanged("ContadorPartidas");
            }

        }

        /// <summary>
        /// Evento del botón que crea una nueva partida
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        public void Button_Click(object sender, RoutedEventArgs e)
        {
            Random miAleatorio = new Random();
            listadoActoresJugadaActual.Clear();
            respuestasAcertadas = 0;
            NotifyPropertyChanged("RespuestasAcertadas");
            respuestasIncorrectas = 0;
            NotifyPropertyChanged("RespuestasIncorrectas");
            contadorPartidas = 1;
            NotifyPropertyChanged("ContadorPartidas");
            this.generarRespuestas();
            actorActual = listadoActoresJugadaActual[miAleatorio.Next(0, 4)];
            uriFoto = "ms-appx://CRUDTrivial/Assets/Fotos/" + actorActual.ID + ".jpg";
            NotifyPropertyChanged("URIFoto");
            listadoActoresPartida.Add(actorActual);
        }
        #endregion
    }
}
