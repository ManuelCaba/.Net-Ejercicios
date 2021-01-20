using Microsoft.AspNet.SignalR.Client;
using SignalRUWP.Models;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Windows.UI.Core;
using Windows.UI.Xaml;

namespace SignalRUWP.ViewModels
{
    public class ChatMessageViewModel
    {
        #region Propiedades
        private HubConnection conn;
        private IHubProxy proxy;
        public ChatMessage ActualChatMessage { get; }
        public ObservableCollection<ChatMessage> Messages { get; } = new ObservableCollection<ChatMessage>();
        #endregion

        #region Constructores
        public ChatMessageViewModel()
        {
            ActualChatMessage = new ChatMessage { Username = " ", Message = " " };
            SignalR();
        }
        #endregion

        #region Métodos
        /// <summary>
        /// 
        /// </summary>
        public void SignalR()
        {
            conn = new HubConnection("https://signalrchatmanucaba.azurewebsites.net");
            proxy = conn.CreateHubProxy("ChatHub");
            conn.Start();

            proxy.On<ChatMessage>("broadcastMessage", OnMessage);

        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="chatMessage"></param>
        private void Broadcast(ChatMessage chatMessage)
        {
            proxy.Invoke("Send", chatMessage);
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="chatMessage"></param>
        private async void OnMessage(ChatMessage chatMessage)
        {
            await Windows.ApplicationModel.Core.CoreApplication.MainView.Dispatcher.RunAsync(CoreDispatcherPriority.Normal, () =>
            {
                this.Messages.Add(chatMessage);
            });
        }
        #endregion

        public void send_Click(object sender, RoutedEventArgs e)
        {
            proxy.Invoke("Send", ActualChatMessage);
            //Broadcast(ActualChatMessage);
        }
    }
}
