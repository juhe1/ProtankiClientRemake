package alternativa.tanks.gui.settings.controls
{
   import flash.display.DisplayObject;
   
   public class GridLayout
   {
      
      private var topX:int;
      
      private var topY:int;
      
      private var columnWidth:int;
      
      private var rowHeight:int;
      
      private var rowMargin:int;
      
      public function GridLayout(param1:int, param2:int, param3:int, param4:int)
      {
         super();
         this.topX = param1;
         this.topY = param2;
         this.columnWidth = param3;
         this.rowHeight = param4;
      }
      
      public function layout(param1:Array) : int
      {
         var _loc2_:int = 0;
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         var _loc6_:DisplayObject = null;
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            _loc4_ = param1[_loc3_];
            _loc5_ = 0;
            while(_loc5_ < _loc4_.length)
            {
               if(_loc4_[_loc5_] != null)
               {
                  _loc6_ = _loc4_[_loc5_];
                  _loc6_.x = this.topX + _loc5_ * this.columnWidth;
                  _loc6_.y = this.topY + _loc3_ * this.rowHeight + this.rowMargin * _loc3_;
                  _loc2_ = _loc6_.y + _loc6_.height;
               }
               _loc5_++;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function getRowMargin() : int
      {
         return this.rowMargin;
      }
      
      public function setRowMargin(param1:int) : void
      {
         this.rowMargin = param1;
      }
   }
}

