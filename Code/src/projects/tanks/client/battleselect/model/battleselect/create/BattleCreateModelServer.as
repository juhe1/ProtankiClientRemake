package projects.tanks.client.battleselect.model.battleselect.create
{

   import platform.client.fp10.core.model.IModel;
   import projects.tanks.client.battleservice.BattleCreateParameters;
   import scpacker.networking.Network;
   import alternativa.osgi.OSGi;
   import scpacker.networking.protocol.packets.battlecreate.CreateBattleOutPacket;
   import scpacker.networking.protocol.packets.battlecreate.CheckBattleNameOutPacket;

   public class BattleCreateModelServer
   {
      private var model:IModel;
      private var network:Network = OSGi.getInstance().getService(Network) as Network;

      public function BattleCreateModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function checkBattleNameForForbiddenWords(param1:String) : void
      {
         this.network.send(new CheckBattleNameOutPacket(param1));
      }

      public function createBattle(param1:BattleCreateParameters) : void
      {
         this.network.send(new CreateBattleOutPacket(param1));
      }
   }
}
