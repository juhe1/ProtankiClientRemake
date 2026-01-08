package alternativa.tanks.models.battle.assault
{
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.battle.LogicUnit;
   
   public class ASFlagPickupTimeoutTask implements LogicUnit
   {
      
      [Inject]
      public static var battleService:BattleService;
      
      private var callback:IAssaultModel;
      
      private var triggerTime:int;
      
      private var flagId:int;
      
      public function ASFlagPickupTimeoutTask(param1:int, param2:IAssaultModel, param3:int)
      {
         super();
         this.flagId = param1;
         this.callback = param2;
         this.triggerTime = param3;
      }
      
      public function runLogic(param1:int, param2:int) : void
      {
         if(param1 >= this.triggerTime)
         {
            battleService.getBattleRunner().removeLogicUnit(this);
            this.callback.onPickupTimeoutPassed(this.flagId);
         }
      }
   }
}

