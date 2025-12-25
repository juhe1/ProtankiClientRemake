package projects.tanks.client.battlefield.models.battle.battlefield.mine
{
   import platform.client.fp10.core.resource.types.ImageResource;
   import platform.client.fp10.core.resource.types.MultiframeImageResource;
   import platform.client.fp10.core.resource.types.SoundResource;
   import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;
   
   public class BattleMineCC
   {
      
      private var _activateSound:SoundResource;
      
      private var _activateTimeMsec:int;
      
      private var _battleMines:Vector.<BattleMine>;
      
      private var _blueMineTexture:ImageResource;
      
      private var _deactivateSound:SoundResource;
      
      private var _enemyMineTexture:ImageResource;
      
      private var _explosionMarkTexture:ImageResource;
      
      private var _explosionSound:SoundResource;
      
      private var _farVisibilityRadius:Number;
      
      private var _friendlyMineTexture:ImageResource;
      
      private var _idleExplosionTexture:MultiframeImageResource;
      
      private var _impactForce:Number;
      
      private var _mainExplosionTexture:MultiframeImageResource;
      
      private var _minDistanceFromBase:Number;
      
      private var _model3ds:Tanks3DSResource;
      
      private var _nearVisibilityRadius:Number;
      
      private var _radius:Number;
      
      private var _redMineTexture:ImageResource;
      
      public function BattleMineCC(param1:SoundResource = null, param2:int = 0, param3:Vector.<BattleMine> = null, param4:ImageResource = null, param5:SoundResource = null, param6:ImageResource = null, param7:ImageResource = null, param8:SoundResource = null, param9:Number = 0, param10:ImageResource = null, param11:MultiframeImageResource = null, param12:Number = 0, param13:MultiframeImageResource = null, param14:Number = 0, param15:Tanks3DSResource = null, param16:Number = 0, param17:Number = 0, param18:ImageResource = null)
      {
         super();
         this._activateSound = param1;
         this._activateTimeMsec = param2;
         this._battleMines = param3;
         this._blueMineTexture = param4;
         this._deactivateSound = param5;
         this._enemyMineTexture = param6;
         this._explosionMarkTexture = param7;
         this._explosionSound = param8;
         this._farVisibilityRadius = param9;
         this._friendlyMineTexture = param10;
         this._idleExplosionTexture = param11;
         this._impactForce = param12;
         this._mainExplosionTexture = param13;
         this._minDistanceFromBase = param14;
         this._model3ds = param15;
         this._nearVisibilityRadius = param16;
         this._radius = param17;
         this._redMineTexture = param18;
      }
      
      public function get activateSound() : SoundResource
      {
         return this._activateSound;
      }
      
      public function set activateSound(param1:SoundResource) : void
      {
         this._activateSound = param1;
      }
      
      public function get activateTimeMsec() : int
      {
         return this._activateTimeMsec;
      }
      
      public function set activateTimeMsec(param1:int) : void
      {
         this._activateTimeMsec = param1;
      }
      
      public function get battleMines() : Vector.<BattleMine>
      {
         return this._battleMines;
      }
      
      public function set battleMines(param1:Vector.<BattleMine>) : void
      {
         this._battleMines = param1;
      }
      
      public function get blueMineTexture() : ImageResource
      {
         return this._blueMineTexture;
      }
      
      public function set blueMineTexture(param1:ImageResource) : void
      {
         this._blueMineTexture = param1;
      }
      
      public function get deactivateSound() : SoundResource
      {
         return this._deactivateSound;
      }
      
      public function set deactivateSound(param1:SoundResource) : void
      {
         this._deactivateSound = param1;
      }
      
      public function get enemyMineTexture() : ImageResource
      {
         return this._enemyMineTexture;
      }
      
      public function set enemyMineTexture(param1:ImageResource) : void
      {
         this._enemyMineTexture = param1;
      }
      
      public function get explosionMarkTexture() : ImageResource
      {
         return this._explosionMarkTexture;
      }
      
      public function set explosionMarkTexture(param1:ImageResource) : void
      {
         this._explosionMarkTexture = param1;
      }
      
      public function get explosionSound() : SoundResource
      {
         return this._explosionSound;
      }
      
      public function set explosionSound(param1:SoundResource) : void
      {
         this._explosionSound = param1;
      }
      
      public function get farVisibilityRadius() : Number
      {
         return this._farVisibilityRadius;
      }
      
      public function set farVisibilityRadius(param1:Number) : void
      {
         this._farVisibilityRadius = param1;
      }
      
      public function get friendlyMineTexture() : ImageResource
      {
         return this._friendlyMineTexture;
      }
      
      public function set friendlyMineTexture(param1:ImageResource) : void
      {
         this._friendlyMineTexture = param1;
      }
      
      public function get idleExplosionTexture() : MultiframeImageResource
      {
         return this._idleExplosionTexture;
      }
      
      public function set idleExplosionTexture(param1:MultiframeImageResource) : void
      {
         this._idleExplosionTexture = param1;
      }
      
      public function get impactForce() : Number
      {
         return this._impactForce;
      }
      
      public function set impactForce(param1:Number) : void
      {
         this._impactForce = param1;
      }
      
      public function get mainExplosionTexture() : MultiframeImageResource
      {
         return this._mainExplosionTexture;
      }
      
      public function set mainExplosionTexture(param1:MultiframeImageResource) : void
      {
         this._mainExplosionTexture = param1;
      }
      
      public function get minDistanceFromBase() : Number
      {
         return this._minDistanceFromBase;
      }
      
      public function set minDistanceFromBase(param1:Number) : void
      {
         this._minDistanceFromBase = param1;
      }
      
      public function get model3ds() : Tanks3DSResource
      {
         return this._model3ds;
      }
      
      public function set model3ds(param1:Tanks3DSResource) : void
      {
         this._model3ds = param1;
      }
      
      public function get nearVisibilityRadius() : Number
      {
         return this._nearVisibilityRadius;
      }
      
      public function set nearVisibilityRadius(param1:Number) : void
      {
         this._nearVisibilityRadius = param1;
      }
      
      public function get radius() : Number
      {
         return this._radius;
      }
      
      public function set radius(param1:Number) : void
      {
         this._radius = param1;
      }
      
      public function get redMineTexture() : ImageResource
      {
         return this._redMineTexture;
      }
      
      public function set redMineTexture(param1:ImageResource) : void
      {
         this._redMineTexture = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "BattleMineCC [";
         _loc1_ += "activateSound = " + this.activateSound + " ";
         _loc1_ += "activateTimeMsec = " + this.activateTimeMsec + " ";
         _loc1_ += "battleMines = " + this.battleMines + " ";
         _loc1_ += "blueMineTexture = " + this.blueMineTexture + " ";
         _loc1_ += "deactivateSound = " + this.deactivateSound + " ";
         _loc1_ += "enemyMineTexture = " + this.enemyMineTexture + " ";
         _loc1_ += "explosionMarkTexture = " + this.explosionMarkTexture + " ";
         _loc1_ += "explosionSound = " + this.explosionSound + " ";
         _loc1_ += "farVisibilityRadius = " + this.farVisibilityRadius + " ";
         _loc1_ += "friendlyMineTexture = " + this.friendlyMineTexture + " ";
         _loc1_ += "idleExplosionTexture = " + this.idleExplosionTexture + " ";
         _loc1_ += "impactForce = " + this.impactForce + " ";
         _loc1_ += "mainExplosionTexture = " + this.mainExplosionTexture + " ";
         _loc1_ += "minDistanceFromBase = " + this.minDistanceFromBase + " ";
         _loc1_ += "model3ds = " + this.model3ds + " ";
         _loc1_ += "nearVisibilityRadius = " + this.nearVisibilityRadius + " ";
         _loc1_ += "radius = " + this.radius + " ";
         _loc1_ += "redMineTexture = " + this.redMineTexture + " ";
         return _loc1_ + "]";
      }
   }
}

