package alternativa.tanks.models.weapons.targeting.direction.sector.splitter
{
   import alternativa.math.Matrix3;
   import alternativa.math.Vector3;
   import alternativa.tanks.battle.BattleUtils;
   import alternativa.tanks.models.weapon.AllGlobalGunParams;
   import alternativa.tanks.models.weapons.targeting.direction.*;
   import alternativa.tanks.models.weapons.targeting.direction.sector.TargetingSector;
   import alternativa.tanks.models.weapons.targeting.priority.TargetingPriorityCalculator;
   
   public class SectorsSplitter
   {
      
      private const DIRECTIONS_PER_SECTOR:int = 16;
      
      private var targetPriority:TargetingPriorityCalculator;
      
      private var matrix:Matrix3 = new Matrix3();
      
      private var direction:Vector3 = new Vector3();
      
      private var directions:Vector.<TargetingDirection> = new Vector.<TargetingDirection>();
      
      private var currentOverlapSectors:SortedTargetingSectors = new SortedTargetingSectors();
      
      public function SectorsSplitter(param1:TargetingPriorityCalculator)
      {
         super();
         this.targetPriority = param1;
      }
      
      public function splitSectorsOnDirections(param1:AllGlobalGunParams, param2:Vector.<TargetingSector>) : Vector.<TargetingDirection>
      {
         var _loc4_:TargetingSector = null;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc3_:Number = Number.NEGATIVE_INFINITY;
         this.directions.length = 0;
         this.currentOverlapSectors.clear();
         for each(_loc4_ in param2)
         {
            _loc5_ = _loc4_.getLeft();
            while(!this.currentOverlapSectors.isEmpty() && _loc3_ < _loc5_)
            {
               _loc6_ = Math.min(this.currentOverlapSectors.getRight(),_loc5_);
               this.addDirections(param1,_loc3_,_loc6_);
               this.currentOverlapSectors.removeSectorsWhichRightCoordIsLessOrEqualThan(_loc6_);
               _loc3_ = _loc6_;
            }
            _loc3_ = _loc5_;
            this.currentOverlapSectors.add(_loc4_);
         }
         while(!this.currentOverlapSectors.isEmpty())
         {
            _loc6_ = this.currentOverlapSectors.getRight();
            this.addDirections(param1,_loc3_,_loc6_);
            this.currentOverlapSectors.removeSectorsWhichRightCoordIsLessOrEqualThan(_loc6_);
            _loc3_ = _loc6_;
         }
         return this.directions;
      }
      
      private function addDirections(param1:AllGlobalGunParams, param2:Number, param3:Number) : void
      {
         var _loc9_:Vector3 = null;
         var _loc4_:Number = param3 - param2;
         var _loc5_:Number = _loc4_ / this.DIRECTIONS_PER_SECTOR;
         var _loc6_:Number = param2 + _loc5_ * 0.5;
         var _loc7_:Vector.<TargetingSector> = this.currentOverlapSectors.getOrderedByDistance();
         this.matrix.fromAxisAngle(param1.elevationAxis,_loc6_);
         this.matrix.transformVector(param1.direction,this.direction);
         this.matrix.fromAxisAngle(param1.elevationAxis,_loc5_);
         var _loc8_:int = 0;
         while(_loc8_ < this.DIRECTIONS_PER_SECTOR)
         {
            this.directions.push(new TargetingDirection(this.direction,_loc6_,this.targetPriority.getPriorityForSectors(_loc6_,_loc7_)));
            _loc9_ = BattleUtils.tmpVector;
            _loc9_.copy(this.direction);
            this.matrix.transformVector(_loc9_,this.direction);
            _loc6_ += _loc5_;
            _loc8_++;
         }
         if(param2 <= 0 && 0 <= param3)
         {
            this.directions.push(new TargetingDirection(param1.direction,0,this.targetPriority.getPriorityForSectors(0,_loc7_)));
         }
      }
   }
}

