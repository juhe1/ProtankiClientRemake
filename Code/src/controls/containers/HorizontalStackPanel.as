package controls.containers
{
   import flash.display.DisplayObject;
   
   public class HorizontalStackPanel extends StackPanel
   {
      
      public function HorizontalStackPanel()
      {
         super();
      }
      
      override protected function increaseContainerSize(param1:DisplayObject) : void
      {
         var _loc5_:int = 0;
         if(items.length < 2)
         {
            height = param1.y + int(param1.height);
            width = param1.x + fixWidth(param1);
            return;
         }
         var _loc2_:DisplayObject = items[items.length - 2];
         var _loc3_:int = fixWidth(_loc2_);
         var _loc4_:int = fixWidth(param1);
         _loc5_ = param1.x;
         param1.x = _loc2_.x + _loc3_ + getMargin() + _loc5_;
         height = Math.max(int(height),param1.y + int(param1.height));
         width = _loc2_.x + _loc3_ + getMargin() + _loc5_ + _loc4_;
      }
      
      override protected function decreaseContainerSize(param1:int, param2:DisplayObject) : void
      {
         if(param1 <= 0)
         {
            width = 0;
            height = 0;
            return;
         }
         if(param1 == items.length)
         {
            height = this.calculateMaxHeight();
            width = items[items.length - 1].x - fixWidth(items[items.length - 1]);
            return;
         }
         var _loc3_:int = items[param1].x - param2.x;
         var _loc4_:int = param1;
         while(_loc4_ < items.length)
         {
            items[_loc4_].x -= _loc3_;
            _loc4_++;
         }
         width = items[items.length - 1].x + fixWidth(items[items.length - 1]);
         height = this.calculateMaxHeight();
      }
      
      private function calculateMaxHeight() : int
      {
         var _loc2_:DisplayObject = null;
         var _loc1_:int = 0;
         for each(_loc2_ in items)
         {
            _loc1_ = Math.max(_loc1_,_loc2_.y + _loc2_.height);
         }
         return _loc1_;
      }
   }
}

