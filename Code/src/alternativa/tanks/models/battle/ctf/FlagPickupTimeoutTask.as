package alternativa.tanks.models.battle.ctf
{
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.battle.LogicUnit;
   
   public class FlagPickupTimeoutTask implements LogicUnit
   {
      
      [Inject] // added
      public static var battleService:BattleService;
      
      private var callback:ICTFModel;
      
      private var triggerTime:int;
      
      public function FlagPickupTimeoutTask(param1:ICTFModel, param2:int)
      {
         super();
         this.callback = param1;
         this.triggerTime = param2;
      }
      
      public function runLogic(param1:int, param2:int) : void
      {
         if(param1 >= this.triggerTime)
         {
            battleService.getBattleRunner().removeLogicUnit(this);
            this.callback.onPickupTimeoutPassed();
         }
      }
   }
}

