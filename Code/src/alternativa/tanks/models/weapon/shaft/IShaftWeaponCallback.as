package alternativa.tanks.models.weapon.shaft
{
   import alternativa.math.Vector3;
   import alternativa.physics.Body;
   
   [ModelInterface]
   public interface IShaftWeaponCallback
   {
      
      function onBeginEnergyDrain(param1:int) : void;
      
      function onAimedShot(param1:int, param2:Vector3, param3:Vector.<Body>, param4:Vector.<Vector3>) : void;
      
      function onQuickShot(param1:int, param2:Vector3, param3:Vector.<Body>, param4:Vector.<Vector3>) : void;
      
      function onManualTargetingStart() : void;
      
      function onManualTargetingStop(param1:int) : void;
      
      function enteredInManualMode() : void;
   }
}

