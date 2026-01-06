package alternativa.tanks.models.weapon.shaft
{
   import alternativa.math.Vector3;
   import alternativa.tanks.models.weapon.laser.LaserPointer;
   import alternativa.tanks.models.weapon.shaft.states.ShaftTargetPoint;
   import flash.geom.Point;
   
   public interface IShaftWeapon
   {
      
      function isTriggerPulled() : Boolean;
      
      function setEnergyMode(param1:ShaftEnergyMode) : void;
      
      function processEvent(param1:ShaftEventType, param2:* = null) : void;
      
      function getEnergy(param1:int) : Number;
      
      function initReticleDisplay(param1:Point, param2:Point) : void;
      
      function setReticleAlpha(param1:Number) : void;
      
      function disableFollowCamera() : void;
      
      function setIndicatorPosition(param1:int, param2:int) : void;
      
      function startManualTargeting() : void;
      
      function stopManualTargeting() : void;
      
      function isKeyDown(param1:uint) : Boolean;
      
      function hasIntersection() : Boolean;
      
      function fadeChargingEffect() : void;
      
      function getMaxEnergy() : Number;
      
      function hideObjectsInRange(param1:Number) : void;
      
      function performAimedShot(param1:Number) : void;
      
      function performQuickShot(param1:Number) : void;
      
      function onTargetingModeStop() : void;
      
      function canShoot() : Boolean;
      
      function calculateTargetPoint(param1:Vector3, param2:ShaftTargetPoint) : Boolean;
      
      function setLaserPointerScale(param1:Number) : void;
      
      function getLaser() : LaserPointer;
   }
}

