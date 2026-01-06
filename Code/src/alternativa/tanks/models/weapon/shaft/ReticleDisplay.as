package alternativa.tanks.models.weapon.shaft
{
   import alternativa.tanks.models.weapon.laser.LaserPointerEffect;
   import alternativa.tanks.utils.Colorizer;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   import platform.client.fp10.core.resource.types.TextureResource;
   
   public class ReticleDisplay extends Sprite
   {
      
      private static var color2LaserSpotBitmap:Dictionary = new Dictionary();
      
      private var _reticle:Bitmap;
      
      private var laserSpot:Bitmap;
      
      private var laserSpotColor:uint;
      
      public function ReticleDisplay(param1:TextureResource, param2:uint)
      {
         super();
         this.laserSpotColor = param2;
         this.createReticleBitmap(param1);
         this.laserSpot = this.getLaserSpotBitmap(param2);
         addChild(this._reticle);
         addChild(this.laserSpot);
         this.laserSpot.x = (this._reticle.width - this.laserSpot.width) / 2;
         this.laserSpot.y = (this._reticle.height - this.laserSpot.height) / 2;
      }
      
      public function get reticle() : Bitmap
      {
         return this._reticle;
      }
      
      public function setLaserPointerScale(param1:Number) : void
      {
         this.laserSpot.width = LaserPointerEffect.spotTexture.width * param1;
         this.laserSpot.height = LaserPointerEffect.spotTexture.height * param1;
         this.laserSpot.x = (this._reticle.width - this.laserSpot.width) / 2;
         this.laserSpot.y = (this._reticle.height - this.laserSpot.height) / 2;
      }
      
      public function changeLaserSpotColor(param1:uint) : void
      {
         var _loc2_:Bitmap = null;
         if(this.laserSpotColor != param1)
         {
            _loc2_ = this.getLaserSpotBitmap(param1);
            addChild(_loc2_);
            _loc2_.x = this.laserSpot.x;
            _loc2_.y = this.laserSpot.y;
            _loc2_.width = this.laserSpot.width;
            _loc2_.height = this.laserSpot.height;
            removeChild(this.laserSpot);
            this.laserSpot = _loc2_;
            this.laserSpotColor = param1;
         }
      }
      
      private function createReticleBitmap(param1:TextureResource) : void
      {
         var _loc2_:BitmapData = param1.data;
         this._reticle = new Bitmap(_loc2_);
      }
      
      private function getLaserSpotBitmap(param1:uint) : Bitmap
      {
         var _loc2_:Bitmap = color2LaserSpotBitmap[param1];
         if(_loc2_ == null)
         {
            _loc2_ = this.createLaserSpotBitmap(param1);
            color2LaserSpotBitmap[param1] = _loc2_;
         }
         return _loc2_;
      }
      
      private function createLaserSpotBitmap(param1:uint) : Bitmap
      {
         var _loc2_:BitmapData = Colorizer.colorize(LaserPointerEffect.spotTexture,param1,0.75);
         var _loc3_:Bitmap = new Bitmap(_loc2_);
         _loc3_.smoothing = true;
         return _loc3_;
      }
   }
}

