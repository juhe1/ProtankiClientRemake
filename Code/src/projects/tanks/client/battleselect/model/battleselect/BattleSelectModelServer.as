package projects.tanks.client.battleselect.model.battleselect
{
   
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;
   import alternativa.types.Long;
   import scpacker.networking.Network;
   import alternativa.osgi.OSGi;
   import scpacker.networking.protocol.packets.battlelist.SelectBattleInOutPacket;

   public class BattleSelectModelServer
   {
      private var model:IModel;
      private var network:Network = Network(OSGi.getInstance().getService(Network));
      
      public function BattleSelectModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }
      
      public function onSelect(param1:String) : void
      {
         network.send(new SelectBattleInOutPacket(param1));
      }
      
      public function search(param1:Long) : void
      {
      }
   }
}