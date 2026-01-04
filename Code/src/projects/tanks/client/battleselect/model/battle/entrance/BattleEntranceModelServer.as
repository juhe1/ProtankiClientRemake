package projects.tanks.client.battleselect.model.battle.entrance
{
   import platform.client.fp10.core.model.IModel;
   import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
   import scpacker.networking.Network;
   import alternativa.osgi.OSGi;
   import scpacker.networking.protocol.packets.battleInfo.JoinBattleOutPacket;
   import scpacker.networking.protocol.packets.battleInfo.SpectateBattleOutPacket;
   
   public class BattleEntranceModelServer
   {
      private var model:IModel;
      private var network:Network = OSGi.getInstance().getService(Network) as Network;
      
      public function BattleEntranceModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }
      
      public function fight(param1:BattleTeam) : void
      {
         network.send(new JoinBattleOutPacket(param1));
      }
      
      public function joinAsSpectator() : void
      {
         network.send(new SpectateBattleOutPacket());
      }
   }
}

