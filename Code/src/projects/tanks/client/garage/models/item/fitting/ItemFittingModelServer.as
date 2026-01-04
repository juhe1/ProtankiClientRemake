package projects.tanks.client.garage.models.item.fitting
{
   import platform.client.fp10.core.model.IModel;
   import scpacker.networking.Network;
   import alternativa.osgi.OSGi;
   import scpacker.networking.protocol.packets.garage.FitItemOutPacket;
   
   public class ItemFittingModelServer
   {
      private var model:IModel;
      private var network:Network = OSGi.getInstance().getService(Network) as Network;
      
      public function ItemFittingModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }
      
      public function fit(itemId:String) : void
      {
         network.send(new FitItemOutPacket(itemId));
      }
   }
}

