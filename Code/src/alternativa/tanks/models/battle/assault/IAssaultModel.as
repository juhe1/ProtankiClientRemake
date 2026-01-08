package alternativa.tanks.models.battle.assault
{
   [ModelInterface]
   public interface IAssaultModel
   {
      
      function onEnterFlagBaseZone() : void;
      
      function onLeaveFlagBaseZone() : void;
      
      function onFlagTouch(param1:int) : void;
      
      function onPickupTimeoutPassed(param1:int) : void;
   }
}

