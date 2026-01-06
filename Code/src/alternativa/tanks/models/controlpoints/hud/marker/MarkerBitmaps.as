package alternativa.tanks.models.controlpoints.hud.marker
{
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import projects.tanks.client.battlefield.models.battle.cp.ControlPointState;
   
   public class MarkerBitmaps
   {
      
      private static const blueMarkerClass:Class = MarkerBitmaps_blueMarkerClass;
      
      private static const blueMarkerBitmapData:BitmapData = new blueMarkerClass().bitmapData;
      
      private static const grayMarkerClass:Class = MarkerBitmaps_grayMarkerClass;
      
      private static const grayMarkerBitmapData:BitmapData = new grayMarkerClass().bitmapData;
      
      private static const redMarkerClass:Class = MarkerBitmaps_redMarkerClass;
      
      private static const redMarkerBitmapData:BitmapData = new redMarkerClass().bitmapData;
      
      private static const letters:Class = MarkerBitmaps_letters;
      
      private static const markerBitmaps:Dictionary = new Dictionary();
      
      private static const markerWidth:int = redMarkerBitmapData.width;
      
      private static const letterBar:BitmapData = new letters().bitmapData;
      
      private static const letterBitmaps:Dictionary = new Dictionary();
      
      markerBitmaps[ControlPointState.NEUTRAL] = grayMarkerBitmapData;
      markerBitmaps[ControlPointState.BLUE] = blueMarkerBitmapData;
      markerBitmaps[ControlPointState.RED] = redMarkerBitmapData;
      
      public function MarkerBitmaps()
      {
         super();
      }
      
      public static function getMarkerBitmapData(param1:ControlPointState) : BitmapData
      {
         return markerBitmaps[param1];
      }
      
      public static function getLetterImage(param1:String) : BitmapData
      {
         var _loc2_:Number = param1.charCodeAt(0) - "A".charCodeAt(0);
         var _loc3_:BitmapData = letterBitmaps[_loc2_];
         if(_loc3_ == null)
         {
            _loc3_ = new BitmapData(markerWidth,letterBar.height,true,0);
            _loc3_.copyPixels(letterBar,new Rectangle(_loc2_ * markerWidth,0,markerWidth,letterBar.height),new Point());
            letterBitmaps[_loc2_] = _loc3_;
         }
         return _loc3_;
      }
   }
}

