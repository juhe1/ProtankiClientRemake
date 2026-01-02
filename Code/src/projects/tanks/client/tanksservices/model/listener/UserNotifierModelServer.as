package projects.tanks.client.tanksservices.model.listener
{
   import platform.client.fp10.core.model.IModel;
   import scpacker.networking.Network;
   import alternativa.osgi.OSGi;
   import scpacker.networking.protocol.packets.usernotifier.SubscribeStatusOutPacket;
   import scpacker.networking.protocol.packets.usernotifier.UnsubscribeOutPacket;
   
   public class UserNotifierModelServer
   {      
      private var model:IModel;
      private var network:Network = Network(OSGi.getInstance().getService(Network));
      
      public function UserNotifierModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }
      
      public function subscribe(param1:String) : void
      {
         network.send(new SubscribeStatusOutPacket(param1));
      }
      
      public function unsubscribe(param1:Vector.<String>) : void
      {
         network.send(new UnsubscribeOutPacket(param1));
      }
   }
}

