package alternativa.tanks.services.initialeffects
{
   import alternativa.types.Long;
   
   public interface IInitialEffectsService
   {
      
      function takeInitialEffects(param1:String) : Vector.<ClientBattleEffect>;
      
      function addInitialEffect(param1:String, param2:int, param3:int, param4:int) : void;
      
      function removeInitialEffect(param1:String, param2:int) : void;
   }
}

