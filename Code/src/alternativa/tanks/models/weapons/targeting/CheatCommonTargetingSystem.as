package alternativa.tanks.models.weapons.targeting
{
   import alternativa.tanks.models.weapon.WeaponObject;
   import alternativa.tanks.models.weapons.targeting.direction.sector.SectorDirectionCalculator;
   import alternativa.tanks.models.weapons.targeting.priority.TargetingPriorityCalculator;
   import alternativa.tanks.models.weapons.targeting.priority.targeting.CommonTargetPriorityCalculator;
   import alternativa.tanks.models.weapons.targeting.processor.SingleTargetDirectionProcessor;
   import platform.client.fp10.core.type.IGameObject;
   import alternativa.tanks.models.weapons.targeting.direction.sector.CheatSectorDirectionCalculator;
   
   public class CheatCommonTargetingSystem extends TargetingSystem
   {
      
      public function CheatCommonTargetingSystem(param1:IGameObject, param2:WeaponObject, param3:Number)
      {
         var _loc4_:TargetingPriorityCalculator = new TargetingPriorityCalculator(new CommonTargetPriorityCalculator(param2));
         super(new CheatSectorDirectionCalculator(param1,param2,param3,_loc4_),new SingleTargetDirectionProcessor(param1,param3),_loc4_);
      }
   }
}

