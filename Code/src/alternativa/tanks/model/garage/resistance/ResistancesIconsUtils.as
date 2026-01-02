package alternativa.tanks.model.garage.resistance
{
   import flash.display.Bitmap;
   import flash.display.DisplayObjectContainer;
   import projects.tanks.client.commons.types.ItemGarageProperty;
   
   public class ResistancesIconsUtils
   {
      
      public function ResistancesIconsUtils()
      {
         super();
      }
      
      public static function addResistanceIcons(param1:Bitmap, param2:Vector.<ItemGarageProperty>) : void
      {
         var _loc6_:ItemGarageProperty = null;
         var _loc7_:Bitmap = null;
         var _loc3_:DisplayObjectContainer = param1.parent;
         var _loc4_:uint = param2.length;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            _loc6_ = param2[_loc5_];
            _loc7_ = new Bitmap(ResistancesIcons.getBitmapData(_loc6_));
            _loc7_.x = (param1.width - _loc7_.width + 1 >> 1) + param1.x;
            _loc7_.y = (param1.height - _loc7_.height - 7 >> 1) + param1.y;
            _loc3_.addChild(_loc7_);
            _loc5_++;
         }
      }
      
      public static function getResistanceBigIcon(param1:ItemGarageProperty) : Bitmap
      {
         return new Bitmap(ResistancesIcons.getBigBitmapData(param1));
      }
   }
}

