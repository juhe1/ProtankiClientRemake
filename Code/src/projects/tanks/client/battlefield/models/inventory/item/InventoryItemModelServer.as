package projects.tanks.client.battlefield.models.inventory.item
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;
   import scpacker.networking.Network;
   import alternativa.osgi.OSGi;
   import scpacker.networking.protocol.packets.inventory.InventoryItemActivateOutPacket;

   public class InventoryItemModelServer
   {

      private var model:IModel;
      private var network:Network = OSGi.getInstance().getService(Network) as Network;

      public function InventoryItemModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function activate(id:String) : void
      {
         this.network.send(new InventoryItemActivateOutPacket(id));
      }
   }
}
