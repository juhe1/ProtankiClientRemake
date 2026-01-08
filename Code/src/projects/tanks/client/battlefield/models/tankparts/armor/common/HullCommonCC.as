package projects.tanks.client.battlefield.models.tankparts.armor.common
{
   import platform.client.fp10.core.resource.types.SoundResource;
   import platform.client.fp10.core.resource.types.ImageResource;
   import projects.tanks.client.battlefield.models.tankparts.sfx.lighting.entity.LightingSFXEntity;
   
   public class HullCommonCC
   {
      
      private var _damping:Number;
      
      private var _deadColoring:ImageResource;
      
      private var _deathSound:SoundResource;
      
      private var _lightingSFXEntity:LightingSFXEntity;
      
      private var _mass:Number;
      
      public function HullCommonCC(param1:Number = 0, param2:ImageResource = null, param3:SoundResource = null, param4:LightingSFXEntity = null, param5:Number = 0)
      {
         super();
         this._damping = param1;
         this._deadColoring = param2;
         this._deathSound = param3;
         this._lightingSFXEntity = param4;
         this._mass = param5;
      }
      
      public function get damping() : Number
      {
         return this._damping;
      }
      
      public function set damping(param1:Number) : void
      {
         this._damping = param1;
      }
      
      public function get deadColoring() : ImageResource
      {
         return this._deadColoring;
      }
      
      public function set deadColoring(param1:ImageResource) : void
      {
         this._deadColoring = param1;
      }
      
      public function get deathSound() : SoundResource
      {
         return this._deathSound;
      }
      
      public function set deathSound(param1:SoundResource) : void
      {
         this._deathSound = param1;
      }
      
      public function get lightingSFXEntity() : LightingSFXEntity
      {
         return this._lightingSFXEntity;
      }
      
      public function set lightingSFXEntity(param1:LightingSFXEntity) : void
      {
         this._lightingSFXEntity = param1;
      }
      
      public function get mass() : Number
      {
         return this._mass;
      }
      
      public function set mass(param1:Number) : void
      {
         this._mass = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "HullCommonCC [";
         _loc1_ += "damping = " + this.damping + " ";
         _loc1_ += "deadColoring = " + this.deadColoring + " ";
         _loc1_ += "deathSound = " + this.deathSound + " ";
         _loc1_ += "lightingSFXEntity = " + this.lightingSFXEntity + " ";
         _loc1_ += "mass = " + this.mass + " ";
         return _loc1_ + "]";
      }
   }
}

