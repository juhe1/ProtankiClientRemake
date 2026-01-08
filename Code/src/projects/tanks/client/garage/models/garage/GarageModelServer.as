
package projects.tanks.client.garage.models.garage
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;
   import scpacker.networking.Network;
   import alternativa.osgi.OSGi;
   import scpacker.networking.protocol.packets.garage.BuyMultipleItemsOutPacket;
   import scpacker.networking.protocol.packets.garage.MountItemOutPacket;
   import scpacker.networking.protocol.packets.garage.BuyKitOutPacket;
   
   public class GarageModelServer
   {
      private var model:IModel;
      private var network:Network = OSGi.getInstance().getService(Network) as Network;
      
      public function GarageModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }
      
      public function itemBought(param1:String, param2:int, param3:int) : void
      {
         network.send(new BuyMultipleItemsOutPacket(param1,param2,param3));
      }
      
      public function itemMounted(param1:String) : void
      {
         network.send(new MountItemOutPacket(param1));
      }
      
      public function itemUnmounted(param1:IGameObject) : void
      {
      }
      
      public function kitBought(param1:String, param2:int) : void
      {
         network.send(new BuyKitOutPacket(param1, param2));
      }
      
      public function readyToReload() : void
      {
      }
   }
}