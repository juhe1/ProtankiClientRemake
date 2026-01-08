package projects.tanks.client.battlefield.models.battle.ctf
{
   import platform.client.fp10.core.resource.types.SoundResource;
   
   public class CaptureTheFlagSoundFX
   {
      
      private var _enemiesWinSound:SoundResource;
      
      private var _flagDropSound:SoundResource;
      
      private var _flagDroppedByEnemiesSound:SoundResource;
      
      private var _flagReturnSound:SoundResource;
      
      private var _flagReturnedByEnemiesSound:SoundResource;
      
      private var _flagTakeSound:SoundResource;
      
      private var _flagTakenByEnemiesSound:SoundResource;
      
      private var _winSound:SoundResource;
      
      public function CaptureTheFlagSoundFX(param1:SoundResource = null, param2:SoundResource = null, param3:SoundResource = null, param4:SoundResource = null, param5:SoundResource = null, param6:SoundResource = null, param7:SoundResource = null, param8:SoundResource = null)
      {
         super();
         this._enemiesWinSound = param1;
         this._flagDropSound = param2;
         this._flagDroppedByEnemiesSound = param3;
         this._flagReturnSound = param4;
         this._flagReturnedByEnemiesSound = param5;
         this._flagTakeSound = param6;
         this._flagTakenByEnemiesSound = param7;
         this._winSound = param8;
      }
      
      public function get enemiesWinSound() : SoundResource
      {
         return this._enemiesWinSound;
      }
      
      public function set enemiesWinSound(param1:SoundResource) : void
      {
         this._enemiesWinSound = param1;
      }
      
      public function get flagDropSound() : SoundResource
      {
         return this._flagDropSound;
      }
      
      public function set flagDropSound(param1:SoundResource) : void
      {
         this._flagDropSound = param1;
      }
      
      public function get flagDroppedByEnemiesSound() : SoundResource
      {
         return this._flagDroppedByEnemiesSound;
      }
      
      public function set flagDroppedByEnemiesSound(param1:SoundResource) : void
      {
         this._flagDroppedByEnemiesSound = param1;
      }
      
      public function get flagReturnSound() : SoundResource
      {
         return this._flagReturnSound;
      }
      
      public function set flagReturnSound(param1:SoundResource) : void
      {
         this._flagReturnSound = param1;
      }
      
      public function get flagReturnedByEnemiesSound() : SoundResource
      {
         return this._flagReturnedByEnemiesSound;
      }
      
      public function set flagReturnedByEnemiesSound(param1:SoundResource) : void
      {
         this._flagReturnedByEnemiesSound = param1;
      }
      
      public function get flagTakeSound() : SoundResource
      {
         return this._flagTakeSound;
      }
      
      public function set flagTakeSound(param1:SoundResource) : void
      {
         this._flagTakeSound = param1;
      }
      
      public function get flagTakenByEnemiesSound() : SoundResource
      {
         return this._flagTakenByEnemiesSound;
      }
      
      public function set flagTakenByEnemiesSound(param1:SoundResource) : void
      {
         this._flagTakenByEnemiesSound = param1;
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
         var _loc1_:String = "CaptureTheFlagSoundFX [";
         _loc1_ += "enemiesWinSound = " + this.enemiesWinSound + " ";
         _loc1_ += "flagDropSound = " + this.flagDropSound + " ";
         _loc1_ += "flagDroppedByEnemiesSound = " + this.flagDroppedByEnemiesSound + " ";
         _loc1_ += "flagReturnSound = " + this.flagReturnSound + " ";
         _loc1_ += "flagReturnedByEnemiesSound = " + this.flagReturnedByEnemiesSound + " ";
         _loc1_ += "flagTakeSound = " + this.flagTakeSound + " ";
         _loc1_ += "flagTakenByEnemiesSound = " + this.flagTakenByEnemiesSound + " ";
         _loc1_ += "winSound = " + this.winSound + " ";
         return _loc1_ + "]";
      }
   }
}

