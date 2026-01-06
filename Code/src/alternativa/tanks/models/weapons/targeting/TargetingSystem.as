package alternativa.tanks.models.weapons.targeting
{
   import alternativa.physics.collision.types.RayHit;
   import alternativa.tanks.models.weapon.AllGlobalGunParams;
   import alternativa.tanks.models.weapons.targeting.debug.TargetingVisualDebug;
   import alternativa.tanks.models.weapons.targeting.direction.TargetingDirection;
   import alternativa.tanks.models.weapons.targeting.direction.TargetingDirectionCalculator;
   import alternativa.tanks.models.weapons.targeting.priority.TargetingPriorityCalculator;
   import alternativa.tanks.models.weapons.targeting.processor.TargetingDirectionProcessor;
   
   public class TargetingSystem
   {
      
      private static const visualDebug:TargetingVisualDebug = new TargetingVisualDebug();
      
      private var directionCalculator:TargetingDirectionCalculator;
      
      private var priorityCalculator:TargetingPriorityCalculator;
      
      private var directionProcessor:TargetingDirectionProcessor;
      
      private var result:TargetingResult = new TargetingResult();
      
      public function TargetingSystem(param1:TargetingDirectionCalculator, param2:TargetingDirectionProcessor, param3:TargetingPriorityCalculator)
      {
         super();
         this.directionCalculator = param1;
         this.directionProcessor = param2;
         this.priorityCalculator = param3;
      }
      
      public function getProcessor() : TargetingDirectionProcessor
      {
         return this.directionProcessor;
      }
      
      public function target(param1:AllGlobalGunParams) : TargetingResult
      {
         var _loc4_:TargetingDirection = null;
         var _loc5_:Vector.<RayHit> = null;
         var _loc6_:Number = NaN;
         var _loc2_:Vector.<TargetingDirection> = this.directionCalculator.getDirections(param1);
         _loc2_.push(new TargetingDirection(param1.direction,0,0));
         _loc2_.sort(TargetingDirection.comparator);
         var _loc3_:Number = Number.NEGATIVE_INFINITY;
         visualDebug.reset();
         for each(_loc4_ in _loc2_)
         {
            if(_loc4_.getMaxPriority() < _loc3_)
            {
               break;
            }
            _loc5_ = this.directionProcessor.process(param1,_loc4_.getDirection());
            _loc6_ = this.priorityCalculator.getPriorityForRayHits(_loc4_.getAngle(),_loc5_);
            if(_loc6_ > 0)
            {
               _loc6_ += _loc4_.getBonusPriority();
            }
            if(_loc6_ > _loc3_ || _loc6_ == _loc3_ && _loc4_.getAngle() == 0)
            {
               _loc3_ = _loc6_;
               this.result.setData(_loc4_.getDirection(),_loc5_);
            }
         }
         return this.result;
      }
   }
}

