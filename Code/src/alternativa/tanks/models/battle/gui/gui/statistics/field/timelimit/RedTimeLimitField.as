package alternativa.tanks.models.battle.gui.gui.statistics.field.timelimit
{
   import alternativa.tanks.models.battle.gui.gui.statistics.field.wink.WinkManager;
   import flash.display.DisplayObject;
   import flash.filters.BitmapFilter;
   import flash.filters.BitmapFilterQuality;
   import flash.filters.DropShadowFilter;
   import flash.geom.ColorTransform;
   
   public class RedTimeLimitField extends TimeLimitField
   {
      
      public function RedTimeLimitField(param1:int, param2:DisplayObject, param3:WinkManager, param4:Boolean)
      {
         super(param1,param2,param3,param4);
         label.color = 16742220;
         param2.transform.colorTransform = new ColorTransform(0,0,0,1,255,119,76);
         filters = [this.getBitmapFilter()];
      }
      
      private function getBitmapFilter() : BitmapFilter
      {
         var _loc1_:Number = 0;
         var _loc2_:Number = 45;
         var _loc3_:Number = 1;
         var _loc4_:Number = 1;
         var _loc5_:Number = 1;
         var _loc6_:Number = 1;
         var _loc7_:Number = 0.65;
         var _loc8_:Boolean = false;
         var _loc9_:Boolean = false;
         var _loc10_:Number = BitmapFilterQuality.HIGH;
         return new DropShadowFilter(_loc6_,_loc2_,_loc1_,_loc3_,_loc4_,_loc5_,_loc7_,_loc10_,_loc8_,_loc9_);
      }
   }
}

