package alternativa.tanks.models.weapon.streamweapon
{
   import alternativa.engine3d.core.Object3D;
   import alternativa.math.Matrix3;
   import alternativa.math.Matrix4;
   import alternativa.math.Vector3;
   import alternativa.physics.Body;
   import alternativa.physics.collision.CollisionDetector;
   import alternativa.physics.collision.types.RayHit;
   import alternativa.tanks.battle.scene3d.scene3dcontainer.Scene3DContainer;
   import alternativa.tanks.camera.GameCamera;
   import alternativa.tanks.models.sfx.colortransform.ColorTransformEntry;
   import alternativa.tanks.models.weapon.shared.StreamWeaponParticle;
   import alternativa.tanks.physics.CollisionGroup;
   import alternativa.tanks.sfx.GraphicEffect;
   import alternativa.tanks.sfx.SFXUtils;
   import alternativa.tanks.utils.EncryptedInt;
   import alternativa.tanks.utils.EncryptedIntImpl;
   import alternativa.tanks.utils.objectpool.Pool;
   import alternativa.tanks.utils.objectpool.PooledObject;
   import flash.geom.ColorTransform;
   import flash.utils.getTimer;
   
   public class StreamWeaponGraphicEffect extends PooledObject implements GraphicEffect
   {
      
      private static const thousand:EncryptedInt = new EncryptedIntImpl(1000);
      
      private static const MAX_PARTICLES:int = 20;
      
      private static const PARTICLE_ROTATON_SPEED:Number = 3;
      
      private static const matrix:Matrix3 = new Matrix3();
      
      private static const turretMatrix:Matrix4 = new Matrix4();
      
      private static const barrelOrigin:Vector3 = new Vector3();
      
      private static const direction:Vector3 = new Vector3();
      
      private static const turretAxisX:Vector3 = new Vector3();
      
      private static const particlePosition:Vector3 = new Vector3();
      
      private static const globalMuzzlePosition:Vector3 = new Vector3();
      
      private static const intersection:RayHit = new RayHit();
      
      private var _range:Number;
      
      private var coneHalfAngleTan:Number;
      
      private var particleSpeed:Number;
      
      private var localMuzzlePosition:Vector3 = new Vector3();
      
      private var turret:Object3D;
      
      private var sfxData:StreamWeaponSFXData;
      
      private var collisionDetector:CollisionDetector;
      
      private var _particles:Vector.<StreamWeaponParticle> = new Vector.<StreamWeaponParticle>(MAX_PARTICLES);
      
      private var particleSizePerDistance:Number;
      
      private var particleEmissionPeriod:Number;
      
      private var time:int;
      
      private var nextEmissionTime:int;
      
      private var _numParticles:int;
      
      private var container:Scene3DContainer;
      
      private var dead:Boolean;
      
      private var muzzlePlane:StreamWeaponMuzzlePlane;
      
      private var shooterBody:Body;
      
      private var particleStartSize:Number;
      
      private var particleEndSize:Number;
      
      private var particleMuzzleOffset:Number;
      
      private var particleMuzzleRandomOffset:Number;
      
      private var attenuationStartDistance:Number;
      
      public function StreamWeaponGraphicEffect(param1:Pool)
      {
         super(param1);
         this.muzzlePlane = new StreamWeaponMuzzlePlane();
      }
      
      public function init(param1:Body, param2:Number, param3:Number, param4:Number, param5:Vector3, param6:Object3D, param7:StreamWeaponSFXData, param8:CollisionDetector, param9:Number, param10:Number, param11:Number, param12:Number, param13:Number, param14:Number) : void
      {
         this.shooterBody = param1;
         this._range = param2;
         this.attenuationStartDistance = param2 * 0.8;
         this.coneHalfAngleTan = Math.tan(0.5 * param3);
         this.particleSpeed = param4;
         this.localMuzzlePosition.copy(param5);
         this.turret = param6;
         this.sfxData = param7;
         this.collisionDetector = param8;
         this.particleStartSize = param11;
         this.particleEndSize = param12;
         this.particleMuzzleOffset = param13;
         this.particleMuzzleRandomOffset = param14;
         this.muzzlePlane.resize(param9,param10);
         this.particleSizePerDistance = 2 * (param12 - param11) / param2;
         this.particleEmissionPeriod = 1000 * param2 / (MAX_PARTICLES * param4);
         this._numParticles = 0;
         this.time = this.nextEmissionTime = getTimer();
         this.initMuzzlePlane(param7);
         this.dead = false;
      }
      
      private function initMuzzlePlane(param1:StreamWeaponSFXData) : void
      {
         var _loc2_:ColorTransformEntry = null;
         var _loc3_:ColorTransform = null;
         this.muzzlePlane.init(param1.muzzlePlaneAnimation);
         if(param1.muzzlePlaneColorTransformPoints != null)
         {
            _loc2_ = param1.muzzlePlaneColorTransformPoints[0];
            _loc3_ = this.muzzlePlane.colorTransform == null ? new ColorTransform() : this.muzzlePlane.colorTransform;
            _loc3_.alphaMultiplier = _loc2_.alphaMultiplier;
            _loc3_.alphaOffset = _loc2_.alphaOffset;
            _loc3_.redMultiplier = _loc2_.redMultiplier;
            _loc3_.redOffset = _loc2_.redOffset;
            _loc3_.greenMultiplier = _loc2_.greenMultiplier;
            _loc3_.greenOffset = _loc2_.greenOffset;
            _loc3_.blueMultiplier = _loc2_.blueMultiplier;
            _loc3_.blueOffset = _loc2_.blueOffset;
            this.muzzlePlane.colorTransform = _loc3_;
         }
         else
         {
            this.muzzlePlane.colorTransform = null;
         }
      }
      
      public function destroy() : void
      {
         while(this._numParticles > 0)
         {
            this.removeParticle(0);
         }
         this.container.removeChild(this.muzzlePlane);
         this.muzzlePlane.clear();
         this.container = null;
         this.shooterBody = null;
         this.turret = null;
         this.sfxData = null;
         this.collisionDetector = null;
         recycle();
      }
      
      public function play(param1:int, param2:GameCamera) : Boolean
      {
         var _loc3_:Number = NaN;
         var _loc5_:StreamWeaponParticle = null;
         var _loc6_:Vector3 = null;
         var _loc7_:Number = NaN;
         this.calculateParameters();
         _loc3_ = param1 / thousand.getInt();
         if(this.collisionDetector.raycastStatic(barrelOrigin,direction,CollisionGroup.STATIC,this.localMuzzlePosition.y + this.muzzlePlane.length,null,intersection))
         {
            this.muzzlePlane.visible = false;
         }
         else
         {
            this.muzzlePlane.visible = true;
            this.muzzlePlane.update(_loc3_,this.sfxData.muzzlePlaneAnimation.fps);
            SFXUtils.alignObjectPlaneToView(this.muzzlePlane,globalMuzzlePosition,direction,param2.position);
         }
         if(!this.dead && this._numParticles < MAX_PARTICLES && this.time >= this.nextEmissionTime)
         {
            this.nextEmissionTime += this.particleEmissionPeriod;
            this.addParticle();
         }
         var _loc4_:int = 0;
         while(_loc4_ < this._numParticles)
         {
            _loc5_ = this._particles[_loc4_];
            particlePosition.x = _loc5_.x;
            particlePosition.y = _loc5_.y;
            particlePosition.z = _loc5_.z;
            if(_loc5_.particleDistance > this._range || Boolean(this.collisionDetector.raycastStatic(particlePosition,_loc5_.velocity,CollisionGroup.WEAPON,_loc3_,null,intersection)))
            {
               this.removeParticle(_loc4_--);
            }
            else
            {
               _loc6_ = _loc5_.velocity;
               _loc5_.x += _loc6_.x * _loc3_;
               _loc5_.y += _loc6_.y * _loc3_;
               _loc5_.z += _loc6_.z * _loc3_;
               _loc5_.particleDistance += this.particleSpeed * _loc3_;
               _loc5_.rotation += PARTICLE_ROTATON_SPEED * _loc3_ * _loc5_.rotationDirection;
               _loc5_.setFrameIndex(_loc5_.currFrame);
               _loc5_.currFrame += this.sfxData.particleAnimation.fps * _loc3_;
               _loc7_ = this.particleStartSize + this.particleSizePerDistance * _loc5_.particleDistance;
               if(_loc7_ > this.particleEndSize)
               {
                  _loc7_ = this.particleEndSize;
               }
               _loc5_.width = _loc7_;
               _loc5_.height = _loc7_;
               if(_loc5_.particleDistance > this.attenuationStartDistance)
               {
                  _loc5_.alpha = (this._range - _loc5_.particleDistance) / (this._range - this.attenuationStartDistance);
               }
            }
            _loc4_++;
         }
         this.time += param1;
         return !this.dead || this._numParticles > 0;
      }
      
      public function kill() : void
      {
         if(!this.dead)
         {
            this.dead = true;
            this.container.removeChild(this.muzzlePlane);
         }
      }
      
      public function addedToScene(param1:Scene3DContainer) : void
      {
         this.container = param1;
         param1.addChild(this.muzzlePlane);
      }
      
      private function calculateParameters() : void
      {
         turretMatrix.setMatrix(this.turret.x,this.turret.y,this.turret.z,this.turret.rotationX,this.turret.rotationY,this.turret.rotationZ);
         turretAxisX.x = turretMatrix.m00;
         turretAxisX.y = turretMatrix.m10;
         turretAxisX.z = turretMatrix.m20;
         direction.x = turretMatrix.m01;
         direction.y = turretMatrix.m11;
         direction.z = turretMatrix.m21;
         turretMatrix.transformVector(this.localMuzzlePosition,globalMuzzlePosition);
         var _loc1_:Number = this.localMuzzlePosition.y;
         barrelOrigin.x = globalMuzzlePosition.x - _loc1_ * direction.x;
         barrelOrigin.y = globalMuzzlePosition.y - _loc1_ * direction.y;
         barrelOrigin.z = globalMuzzlePosition.z - _loc1_ * direction.z;
      }
      
      private function addParticle() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:StreamWeaponParticle = null;
         _loc1_ = this.particleMuzzleOffset + Math.random() * this.particleMuzzleRandomOffset;
         if(!this.muzzlePlane.visible && intersection.t < this.localMuzzlePosition.y + _loc1_)
         {
            return;
         }
         _loc2_ = StreamWeaponParticle.getParticle();
         _loc2_.setAnimationData(this.sfxData.particleAnimation);
         _loc2_.rotation = Math.random() * Math.PI * 2;
         _loc2_.currFrame = Math.random() * _loc2_.getNumFrames();
         this.getParticleFlightDirection(direction);
         _loc2_.velocity.x = this.particleSpeed * direction.x;
         _loc2_.velocity.y = this.particleSpeed * direction.y;
         _loc2_.velocity.z = this.particleSpeed * direction.z;
         _loc2_.velocity.add(this.shooterBody.state.velocity);
         _loc2_.particleDistance = _loc1_;
         _loc2_.x = globalMuzzlePosition.x + _loc1_ * direction.x;
         _loc2_.y = globalMuzzlePosition.y + _loc1_ * direction.y;
         _loc2_.z = globalMuzzlePosition.z + _loc1_ * direction.z;
         _loc2_.rotationDirection = Math.random() < 0.5 ? 1 : -1;
         this._particles[this._numParticles++] = _loc2_;
         this.container.addChild(_loc2_);
      }
      
      private function removeParticle(param1:int) : void
      {
         var _loc2_:StreamWeaponParticle = this._particles[param1];
         this._particles[param1] = this._particles[--this._numParticles];
         this._particles[this._numParticles] = null;
         this.container.removeChild(_loc2_);
         _loc2_.dispose();
      }
      
      private function getParticleFlightDirection(param1:Vector3) : void
      {
         var _loc2_:Number = 2 * Math.PI * Math.random();
         matrix.fromAxisAngle(param1,_loc2_);
         turretAxisX.transform3(matrix);
         var _loc3_:Number = this._range * this.coneHalfAngleTan * Math.random();
         param1.x = param1.x * this._range + turretAxisX.x * _loc3_;
         param1.y = param1.y * this._range + turretAxisX.y * _loc3_;
         param1.z = param1.z * this._range + turretAxisX.z * _loc3_;
         param1.normalize();
      }
      
      public function get particles() : Vector.<StreamWeaponParticle>
      {
         return this._particles;
      }
      
      public function get numParticles() : int
      {
         return this._numParticles;
      }
      
      public function get range() : Number
      {
         return this._range;
      }
   }
}

