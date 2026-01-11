package projects.tanks.client.battlefield.models.tankparts.sfx.bcsh
{
   public class BCSHStruct
   {
      
      private var _brightness:Number;
      
      private var _contrast:Number;
      
      private var _hue:Number;
      
      private var _key:String;
      
      private var _saturation:Number;
      
      public function BCSHStruct(param1:Number = 0, param2:Number = 0, param3:Number = 0, param4:String = null, param5:Number = 0)
      {
         super();
         this._brightness = param1;
         this._contrast = param2;
         this._hue = param3;
         this._key = param4;
         this._saturation = param5;
      }
      
      public function get brightness() : Number
      {
         return this._brightness;
      }
      
      public function set brightness(param1:Number) : void
      {
         this._brightness = param1;
      }
      
      public function get contrast() : Number
      {
         return this._contrast;
      }
      
      public function set contrast(param1:Number) : void
      {
         this._contrast = param1;
      }
      
      public function get hue() : Number
      {
         return this._hue;
      }
      
      public function set hue(param1:Number) : void
      {
         this._hue = param1;
      }
      
      public function get key() : String
      {
         return this._key;
      }
      
      public function set key(param1:String) : void
      {
         this._key = param1;
      }
      
      public function get saturation() : Number
      {
         return this._saturation;
      }
      
      public function set saturation(param1:Number) : void
      {
         this._saturation = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "BCSHStruct [";
         _loc1_ += "brightness = " + this.brightness + " ";
         _loc1_ += "contrast = " + this.contrast + " ";
         _loc1_ += "hue = " + this.hue + " ";
         _loc1_ += "key = " + this.key + " ";
         _loc1_ += "saturation = " + this.saturation + " ";
         return _loc1_ + "]";
      }
   }
}

