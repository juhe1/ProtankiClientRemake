package controls.containers
{
   import flash.display.DisplayObject;
   
   public class VerticalStackPanel extends StackPanel
   {
      
      public function VerticalStackPanel()
      {
         super();
      }
      
      override protected function increaseContainerSize(param1:DisplayObject) : void
      {
         if(items.length < 2)
         {
            height = param1.y + int(param1.height);
            width = Math.max(width,param1.x + fixWidth(param1));
            return;
         }
         var _loc2_:DisplayObject = items[items.length - 2];
         var _loc3_:int = param1.y;
         param1.y = _loc2_.y + int(_loc2_.height) + getMargin() + param1.y;
         height = _loc2_.y + int(_loc2_.height) + getMargin() + _loc3_ + int(param1.height);
         width = Math.max(int(width),param1.x + fixWidth(param1));
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
            width = this.calculateMaxWidth();
            height = items[items.length - 1].y + int(items[items.length - 1].height);
            return;
         }
         var _loc3_:int = items[param1].y - param2.y;
         var _loc4_:int = param1;
         while(_loc4_ < items.length)
         {
            items[_loc4_].y -= _loc3_;
            _loc4_++;
         }
         height = items[items.length - 1].y + int(items[items.length - 1].height);
         width = this.calculateMaxWidth();
      }
      
      private function calculateMaxWidth() : int
      {
         var _loc2_:DisplayObject = null;
         var _loc1_:int = 0;
         for each(_loc2_ in items)
         {
            _loc1_ = Math.max(_loc1_,_loc2_.x + fixWidth(_loc2_));
         }
         return _loc1_;
      }
   }
}

