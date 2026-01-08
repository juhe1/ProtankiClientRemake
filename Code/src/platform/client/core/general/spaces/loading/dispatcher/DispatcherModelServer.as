
package platform.client.core.general.spaces.loading.dispatcher
{
   import alternativa.osgi.OSGi;
   import scpacker.networking.protocol.packets.init.ResourcesLoadedOutPacket;
   import platform.client.fp10.core.model.IModel;
   import scpacker.networking.Network;
   
   public class DispatcherModelServer
   {
      private var network:Network = Network(OSGi.getInstance().getService(Network));
      
      public function DispatcherModelServer(param1:IModel)
      {
         super();
      }
      
      public function dependenciesLoaded(param1:int) : void
      {
         network.send(new ResourcesLoadedOutPacket(param1));
      }
   }
}