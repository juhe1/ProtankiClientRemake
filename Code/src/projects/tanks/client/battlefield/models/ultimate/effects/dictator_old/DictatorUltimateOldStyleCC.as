package projects.tanks.client.battlefield.models.ultimate.effects.dictator_old
{
   import platform.client.fp10.core.resource.types.SoundResource;
   import platform.client.fp10.core.resource.types.ImageResource;
   
   public class DictatorUltimateOldStyleCC
   {
      
      private var _activateSound:SoundResource;
      
      private var _negativeColorTransform:String;
      
      private var _positiveColorTransform:String;
      
      private var _sparkImage:ImageResource;
      
      public function DictatorUltimateOldStyleCC(param1:SoundResource = null, param2:String = null, param3:String = null, param4:ImageResource = null)
      {
         super();
         this._activateSound = param1;
         this._negativeColorTransform = param2;
         this._positiveColorTransform = param3;
         this._sparkImage = param4;
      }
      
      public function get activateSound() : SoundResource
      {
         return this._activateSound;
      }
      
      public function set activateSound(param1:SoundResource) : void
      {
         this._activateSound = param1;
      }
      
      public function get negativeColorTransform() : String
      {
         return this._negativeColorTransform;
      }
      
      public function set negativeColorTransform(param1:String) : void
      {
         this._negativeColorTransform = param1;
      }
      
      public function get positiveColorTransform() : String
      {
         return this._positiveColorTransform;
      }
      
      public function set positiveColorTransform(param1:String) : void
      {
         this._positiveColorTransform = param1;
      }
      
      public function get sparkImage() : ImageResource
      {
         return this._sparkImage;
      }
      
      public function set sparkImage(param1:ImageResource) : void
      {
         this._sparkImage = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "DictatorUltimateOldStyleCC [";
         _loc1_ += "activateSound = " + this.activateSound + " ";
         _loc1_ += "negativeColorTransform = " + this.negativeColorTransform + " ";
         _loc1_ += "positiveColorTransform = " + this.positiveColorTransform + " ";
         _loc1_ += "sparkImage = " + this.sparkImage + " ";
         return _loc1_ + "]";
      }
   }
}

