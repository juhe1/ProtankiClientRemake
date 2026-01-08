package alternativa.tanks.models.battle.ctf
{
   [ModelInterface]
   public interface ICTFModel
   {
      
      function onEnterFlagBaseZone() : void;
      
      function onLeaveFlagBaseZone() : void;
      
      function onFlagTouch(param1:CTFFlag) : void;
      
      function onPickupTimeoutPassed() : void;
   }
}

