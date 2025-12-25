package projects.tanks.client.battlefield.models.battle.assault
{
   import platform.client.fp10.core.resource.types.SoundResource;
   
   public class AssaultSoundFX
   {
      
      private var _flagDropSound:SoundResource;
      
      private var _flagReturnSound:SoundResource;
      
      private var _flagTakeSound:SoundResource;
      
      private var _winSound:SoundResource;
      
      public function AssaultSoundFX(param1:SoundResource = null, param2:SoundResource = null, param3:SoundResource = null, param4:SoundResource = null)
      {
         super();
         this._flagDropSound = param1;
         this._flagReturnSound = param2;
         this._flagTakeSound = param3;
         this._winSound = param4;
      }
      
      public function get flagDropSound() : SoundResource
      {
         return this._flagDropSound;
      }
      
      public function set flagDropSound(param1:SoundResource) : void
      {
         this._flagDropSound = param1;
      }
      
      public function get flagReturnSound() : SoundResource
      {
         return this._flagReturnSound;
      }
      
      public function set flagReturnSound(param1:SoundResource) : void
      {
         this._flagReturnSound = param1;
      }
      
      public function get flagTakeSound() : SoundResource
      {
         return this._flagTakeSound;
      }
      
      public function set flagTakeSound(param1:SoundResource) : void
      {
         this._flagTakeSound = param1;
      }
      
      public function get winSound() : SoundResource
      {
         return this._winSound;
      }
      
      public function set winSound(param1:SoundResource) : void
      {
         this._winSound = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "AssaultSoundFX [";
         _loc1_ += "flagDropSound = " + this.flagDropSound + " ";
         _loc1_ += "flagReturnSound = " + this.flagReturnSound + " ";
         _loc1_ += "flagTakeSound = " + this.flagTakeSound + " ";
         _loc1_ += "winSound = " + this.winSound + " ";
         return _loc1_ + "]";
      }
   }
}

