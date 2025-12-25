package controls.buttons
{
   import flash.display.BitmapData;
   
   public class FixedHeightRectangleSkin
   {
      
      private var _left:BitmapData;
      
      private var _middle:BitmapData;
      
      private var _right:BitmapData;
      
      public function FixedHeightRectangleSkin(param1:Class = null, param2:Class = null, param3:Class = null)
      {
         super();
         if(param1 == null || param2 == null || param3 == null)
         {
            return;
         }
         this._left = new param1().bitmapData;
         this._middle = new param2().bitmapData;
         this._right = new param3().bitmapData;
      }
      
      public static function createSkin(param1:BitmapData, param2:BitmapData, param3:BitmapData) : FixedHeightRectangleSkin
      {
         var _loc4_:FixedHeightRectangleSkin = new FixedHeightRectangleSkin();
         _loc4_._left = param1;
         _loc4_._right = param3;
         _loc4_._middle = param2;
         return _loc4_;
      }
      
      public function get left() : BitmapData
      {
         return this._left;
      }
      
      public function get middle() : BitmapData
      {
         return this._middle;
      }
      
      public function get right() : BitmapData
      {
         return this._right;
      }
   }
}

