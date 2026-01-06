package alternativa.tanks.models.weapons.targeting.direction.sector.splitter
{
   import alternativa.tanks.models.weapons.targeting.direction.sector.TargetingSector;
   
   public class SortedTargetingSectors
   {
      
      private var orderByRight:Vector.<TargetingSector> = new Vector.<TargetingSector>();
      
      private var orderByDistance:Vector.<TargetingSector> = new Vector.<TargetingSector>();
      
      public function SortedTargetingSectors()
      {
         super();
      }
      
      public function clear() : void
      {
         this.orderByRight.length = 0;
         this.orderByDistance.length = 0;
      }
      
      public function getOrderedByDistance() : Vector.<TargetingSector>
      {
         return this.orderByDistance;
      }
      
      public function getRight() : Number
      {
         var _loc1_:TargetingSector = this.orderByRight[0];
         return _loc1_.getRight();
      }
      
      public function isEmpty() : Boolean
      {
         return this.orderByRight.length == 0;
      }
      
      public function add(param1:TargetingSector) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:TargetingSector = null;
         var _loc4_:TargetingSector = null;
         _loc2_ = 0;
         while(_loc2_ < this.orderByRight.length)
         {
            _loc3_ = this.orderByRight[_loc2_];
            if(param1.getRight() < _loc3_.getRight())
            {
               break;
            }
            _loc2_++;
         }
         this.orderByRight.splice(_loc2_,0,param1);
         _loc2_ = 0;
         while(_loc2_ < this.orderByDistance.length)
         {
            _loc4_ = this.orderByDistance[_loc2_];
            if(param1.getDistance() < _loc4_.getDistance())
            {
               break;
            }
            _loc2_++;
         }
         this.orderByDistance.splice(_loc2_,0,param1);
      }
      
      public function removeSectorsWhichRightCoordIsLessOrEqualThan(param1:Number) : void
      {
         var _loc2_:TargetingSector = null;
         while(this.orderByRight.length > 0)
         {
            _loc2_ = TargetingSector(this.orderByRight[0]);
            if(_loc2_.getRight() > param1)
            {
               break;
            }
            this.removeSector(this.orderByRight[0]);
         }
      }
      
      private function removeSector(param1:TargetingSector) : void
      {
         this.removeElement(this.orderByRight,param1);
         this.removeElement(this.orderByDistance,param1);
      }
      
      private function removeElement(param1:Vector.<TargetingSector>, param2:TargetingSector) : void
      {
         param1.splice(param1.indexOf(param2),1);
      }
   }
}

