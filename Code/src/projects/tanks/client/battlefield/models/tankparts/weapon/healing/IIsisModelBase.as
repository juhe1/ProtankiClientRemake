package projects.tanks.client.battlefield.models.tankparts.weapon.healing
{
   import projects.tanks.client.battlefield.models.tankparts.weapons.common.discrete.TargetHit;
   
   public interface IIsisModelBase
   {
      
      function addEnergy(param1:int) : void;
      
      function resetTarget() : void;
      
      function setTarget(param1:IsisState, param2:TargetHit) : void;
      
      function stopWeapon() : void;
   }
}

