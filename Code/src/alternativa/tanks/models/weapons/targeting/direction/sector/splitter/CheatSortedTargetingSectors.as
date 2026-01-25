package alternativa.tanks.models.weapons.targeting.direction.sector.splitter
{
   import alternativa.tanks.models.weapons.targeting.direction.sector.TargetingSector2D;
   
   public class CheatSortedTargetingSectors
   {
      
      private var orderByUp:Vector.<TargetingSector2D> = new Vector.<TargetingSector2D>();
      
      private var orderByDistance:Vector.<TargetingSector2D> = new Vector.<TargetingSector2D>();
      
      public function CheatSortedTargetingSectors()
      {
         super();
      }
      
      public function clear() : void
      {
         this.orderByUp.length = 0;
         this.orderByDistance.length = 0;
      }
      
      public function getOrderedByDistance() : Vector.<TargetingSector2D>
      {
         return this.orderByDistance;
      }
      
      public function getUp() : Number
      {
         var _loc1_:TargetingSector2D = this.orderByUp[0];
         return _loc1_.getUp();
      }
      
      public function isEmpty() : Boolean
      {
         return this.orderByUp.length == 0;
      }
      
      public function add(param1:TargetingSector2D) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:TargetingSector2D = null;
         var _loc4_:TargetingSector2D = null;
         _loc2_ = 0;
         while(_loc2_ < this.orderByUp.length)
         {
            _loc3_ = this.orderByUp[_loc2_];
            if(param1.getUp() < _loc3_.getUp())
            {
               break;
            }
            _loc2_++;
         }
         this.orderByUp.splice(_loc2_,0,param1);
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
      
      public function removeSectorsWhichUpCoordIsLessOrEqualThan(param1:Number) : void
      {
         var _loc2_:TargetingSector2D = null;
         while(this.orderByUp.length > 0)
         {
            _loc2_ = TargetingSector2D(this.orderByUp[0]);
            if(_loc2_.getUp() > param1)
            {
               break;
            }
            this.removeSector(this.orderByUp[0]);
         }
      }
      
      private function removeSector(param1:TargetingSector2D) : void
      {
         this.removeElement(this.orderByUp,param1);
         this.removeElement(this.orderByDistance,param1);
      }
      
      private function removeElement(param1:Vector.<TargetingSector2D>, param2:TargetingSector2D) : void
      {
         param1.splice(param1.indexOf(param2),1);
      }
   }
}

