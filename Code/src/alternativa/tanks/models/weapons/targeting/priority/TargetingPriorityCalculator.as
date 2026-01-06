package alternativa.tanks.models.weapons.targeting.priority
{
   import alternativa.physics.Body;
   import alternativa.physics.collision.types.RayHit;
   import alternativa.tanks.models.weapons.targeting.direction.sector.TargetingSector;
   import alternativa.tanks.models.weapons.targeting.priority.targeting.TargetPriorityCalculator;
   
   public class TargetingPriorityCalculator
   {
      
      private var priorityEvalutor:TargetPriorityCalculator;
      
      private var weakingCoef:Number;
      
      public function TargetingPriorityCalculator(param1:TargetPriorityCalculator, param2:Number = 0)
      {
         super();
         this.priorityEvalutor = param1;
         this.weakingCoef = param2;
      }
      
      public function getPriorityForSectors(param1:Number, param2:Vector.<TargetingSector>) : Number
      {
         var _loc5_:TargetingSector = null;
         var _loc3_:Number = 0;
         var _loc4_:int = param2.length - 1;
         while(_loc4_ >= 0)
         {
            _loc5_ = param2[_loc4_];
            _loc3_ = Math.max(this.getPriorityForSector(_loc5_,param1) + this.weakingCoef * _loc3_,_loc3_);
            _loc4_--;
         }
         return _loc3_;
      }
      
      private function getPriorityForSector(param1:TargetingSector, param2:Number) : Number
      {
         return this.priorityEvalutor.getTargetPriority(param1.getTank(),param1.getDistance(),param2);
      }
      
      public function getPriorityForRayHits(param1:Number, param2:Vector.<RayHit>) : Number
      {
         var _loc5_:RayHit = null;
         var _loc3_:Number = 1;
         var _loc4_:Number = 0;
         for each(_loc5_ in param2)
         {
            _loc4_ += this.getPriorityForRayHit(param1,_loc5_) * _loc3_;
            _loc3_ *= this.weakingCoef;
         }
         return _loc4_;
      }
      
      private function getPriorityForRayHit(param1:Number, param2:RayHit) : Number
      {
         var _loc3_:Body = param2.shape.body;
         if(param2.staticHit)
         {
            return 0;
         }
         return this.priorityEvalutor.getTargetPriority(_loc3_.tank,param2.t,param1);
      }
   }
}

