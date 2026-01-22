package projects.tanks.clients.fp10.libraries.tanksservices.service.address.events
{
   import alternativa.types.Long;
   import flash.events.Event;
   
   public class BattleChangedAddressEvent extends Event
   {
      
      private var battleId:String;
      
      public function BattleChangedAddressEvent(param1:String)
      {
         super(TanksAddressEvent.BATTLE_CHANGED);
         this.battleId = param1;
      }
      
      public function getBattleId() : String
      {
         return this.battleId;
      }
   }
}

