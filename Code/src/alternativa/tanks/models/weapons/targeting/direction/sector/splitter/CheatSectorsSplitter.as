package alternativa.tanks.models.weapons.targeting.direction.sector.splitter
{
   import alternativa.math.Matrix3;
   import alternativa.math.Vector3;
   import alternativa.tanks.battle.BattleUtils;
   import alternativa.tanks.models.weapon.AllGlobalGunParams;
   import alternativa.tanks.models.weapons.targeting.direction.*;
   import alternativa.tanks.models.weapons.targeting.priority.TargetingPriorityCalculator;
   import alternativa.tanks.models.weapons.targeting.direction.sector.TargetingSector2D;
   import alternativa.osgi.service.console.Console;
   import alternativa.tanks.models.weapons.targeting.debug.TargetingVisualDebug;
   
   public class CheatSectorsSplitter
   {
      
      // Use only 5 direction per sector in 2D aiming mode to improve performance.
      private const DIRECTIONS_PER_SECTOR_2D_AIM:int = 5;

      private const DIRECTIONS_PER_SECTOR:int = 16;
      
      private var targetPriority:TargetingPriorityCalculator;
      
      private var matrix:Matrix3 = new Matrix3();
      
      private var direction:Vector3 = new Vector3();
      
      private var directions:Vector.<TargetingDirection> = new Vector.<TargetingDirection>();
      
      private var currentSectors:Vector.<TargetingSector2D> = new Vector.<TargetingSector2D>();
      public static var targetingVisualDebug:TargetingVisualDebug = new TargetingVisualDebug();
      
      public function CheatSectorsSplitter(param1:TargetingPriorityCalculator)
      {
         super();
         this.targetPriority = param1;
      }
      
      public function splitSectorsOnDirections(gunParams:AllGlobalGunParams, sectors:Vector.<TargetingSector2D>) : Vector.<TargetingDirection>
      {
         targetingVisualDebug.reset();
         var sector:TargetingSector2D = null;
         this.directions.length = 0;
         this.currentSectors.length = 0;
         for each(sector in sectors)
         {
            this.currentSectors.push(sector);
            this.addDirections(gunParams, sector.getDown(), sector.getUp(), sector.getLeft(), sector.getRight());
         }
         return this.directions;
      }
      
      private function addDirections(param1:AllGlobalGunParams, down:Number, up:Number, left:Number, right:Number) : void
      {
         var horizontalLoopLength:int = this.DIRECTIONS_PER_SECTOR_2D_AIM;
         var verticalLoopLength:int = this.DIRECTIONS_PER_SECTOR_2D_AIM;

         // If target is right in front, only one horizontal direction is needed.
         if(left == 0 && right == 0)
         {
            horizontalLoopLength = 1;
            verticalLoopLength = this.DIRECTIONS_PER_SECTOR;
         }

         var _loc9_:Vector3 = null;
         var _loc4_:Number = up - down;
         var _loc5_:Number = _loc4_ / verticalLoopLength;
         var _loc6_:Number = down + _loc5_ * 0.5;
         var _loc7_:Vector.<TargetingSector2D> = sortSectorsByDistance(this.currentSectors);
         var horizontalRange:Number = right - left;
         var horizontalStep:Number = horizontalRange / horizontalLoopLength;
         var currentHorizontal:Number = left + horizontalStep * 0.5;
         var horizontalIndex:int = 0;
         
         // Calculate rotation axis as cross product of elevation axis and direction
         var rotationAxis:Vector3 = new Vector3();
         rotationAxis.cross2(param1.elevationAxis, param1.direction);
         rotationAxis.normalize();
         
         var horizontalMatrix:Matrix3 = new Matrix3();

         while(horizontalIndex < horizontalLoopLength)
         {
            _loc6_ = down + _loc5_ * 0.5;
            this.matrix.fromAxisAngle(param1.elevationAxis,_loc6_);
            this.matrix.transformVector(param1.direction,this.direction);
            this.matrix.fromAxisAngle(param1.elevationAxis,_loc5_);

            // Apply horizontal rotation
            horizontalMatrix.fromAxisAngle(rotationAxis, currentHorizontal);
            horizontalMatrix.transformVector(this.direction, this.direction);
            
            var _loc8_:int = 0;

            while(_loc8_ < verticalLoopLength)
            {
               targetingVisualDebug.addRay(param1,this.direction,10000);

               this.directions.push(new TargetingDirection(this.direction,_loc6_,this.targetPriority.getPriorityForSectors2D(_loc6_,_loc7_)));
               _loc9_ = BattleUtils.tmpVector;
               _loc9_.copy(this.direction);
               this.matrix.transformVector(_loc9_,this.direction);
               _loc6_ += _loc5_;
               _loc8_++;
            }
            
            currentHorizontal += horizontalStep;
            horizontalIndex++;
         }
         if(down <= 0 && 0 <= up)
         {
            this.directions.push(new TargetingDirection(param1.direction,0,this.targetPriority.getPriorityForSectors2D(0,_loc7_)));
         }
      }
      
      public function sortSectorsByDistance(sectors:Vector.<TargetingSector2D>) : Vector.<TargetingSector2D>
      {
         var sorted:Vector.<TargetingSector2D> = sectors.slice();
         sorted.sort(compareByDistance);
         return sorted;
      }
      
      private function compareByDistance(a:TargetingSector2D, b:TargetingSector2D) : Number
      {
         return a.getDistance() - b.getDistance();
      }
   }
}

