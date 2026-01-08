package alternativa.tanks.models.battle.assault.hud
{
   import alternativa.math.Vector3;
   import alternativa.tanks.models.controlpoints.hud.KeyPointView;
   import alternativa.tanks.models.controlpoints.hud.marker.MarkerBitmaps;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.PixelSnapping;
   import flash.display.Sprite;
   import projects.tanks.client.battlefield.models.battle.cp.ControlPointState;
   
   public class ASMarker extends Sprite
   {
      
      private static const asIconClass:Class = ASMarker_asIconClass;
      
      private static const asIconBitmapData:BitmapData = Bitmap(new asIconClass()).bitmapData;
      
      private var container:Sprite = new Sprite();
      
      private var imageBlue:Bitmap;
      
      private var position:Vector3;
      
      public function ASMarker(param1:Vector3)
      {
         super();
         this.position = param1;
         this.createImages();
      }
      
      private static function createMarkerBitmap(param1:ControlPointState) : Bitmap
      {
         return new Bitmap(MarkerBitmaps.getMarkerBitmapData(param1),PixelSnapping.AUTO,true);
      }
      
      private function createImages() : void
      {
         this.imageBlue = createMarkerBitmap(ControlPointState.BLUE);
         addChild(this.container);
         var _loc1_:Bitmap = new Bitmap(asIconBitmapData);
         _loc1_.x = 3;
         _loc1_.y = 1;
         addChild(_loc1_);
         this.container.addChild(this.imageBlue);
         this.visible = true;
      }
      
      public function readPosition3D(param1:Vector3) : void
      {
         param1.copy(this.position);
         param1.z += KeyPointView.CIRCLE_ASCENSION;
      }
   }
}

