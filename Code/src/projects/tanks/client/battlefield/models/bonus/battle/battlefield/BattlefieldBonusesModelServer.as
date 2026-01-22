package projects.tanks.client.battlefield.models.bonus.battle.battlefield
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;
   import alternativa.types.Long;
   import scpacker.networking.Network;
   import alternativa.osgi.OSGi;
   import scpacker.networking.protocol.packets.battle.CollectBonusBoxOutPacket;
   import scpacker.utils.LongUtils;

   public class BattlefieldBonusesModelServer
   {

      private var model:IModel;
      private var network:Network = OSGi.getInstance().getService(Network) as Network;

      public function BattlefieldBonusesModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function attemptToTakeBonus(param1:Long) : void
      {
         this.network.send(new CollectBonusBoxOutPacket(LongUtils.idToStr(param1)));
      }
   }
}
