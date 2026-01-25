package alternativa.tanks.models.weapons.targeting.direction.sector
{
   import alternativa.tanks.models.weapon.AllGlobalGunParams;
   import alternativa.tanks.models.weapon.WeaponObject;
   import alternativa.tanks.models.weapons.targeting.direction.TargetingDirection;
   import alternativa.tanks.models.weapons.targeting.direction.TargetingDirectionCalculator;
   import alternativa.tanks.models.weapons.targeting.direction.sector.splitter.SectorsSplitter;
   import platform.client.fp10.core.type.IGameObject;
   import alternativa.tanks.models.weapons.targeting.direction.sector.splitter.CheatSectorsSplitter;
   import alternativa.tanks.models.weapons.targeting.priority.TargetingPriorityCalculator;
   
   public class CheatSectorDirectionCalculator implements TargetingDirectionCalculator
   {
      
      private var targetingSectorsCalculator:CheatTargetingSectorsCalculator;
      
      private var sectorsSplitter:CheatSectorsSplitter;
      
      public function CheatSectorDirectionCalculator(param1:IGameObject, param2:WeaponObject, param3:Number, param4:TargetingPriorityCalculator)
      {
         super();
         this.targetingSectorsCalculator = new CheatTargetingSectorsCalculator(param1,param2,param3);
         this.sectorsSplitter = new CheatSectorsSplitter(param4);
      }
      
      public function getDirections(param1:AllGlobalGunParams) : Vector.<TargetingDirection>
      {
         var _loc2_:Vector.<TargetingSector2D> = this.targetingSectorsCalculator.getSectors(param1);
         return this.sectorsSplitter.splitSectorsOnDirections(param1,_loc2_);
      }
   }
}

