using System;
using System.Web;
using Microsoft.AspNet.SignalR;
using SignalRChat.Models;

namespace SignalRChat
{
    public class ChatHub : Hub
    {
        public void Send(ChatMessage chatMessage)
        {
            // Call the broadcastMessage method to update clients.
            Clients.All.broadcastMessage(chatMessage);
        }
    }
}