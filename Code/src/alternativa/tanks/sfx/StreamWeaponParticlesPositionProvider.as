package alternativa.tanks.sfx
{
   import alternativa.engine3d.core.Object3D;
   import alternativa.tanks.camera.GameCamera;
   import alternativa.tanks.models.weapon.shared.StreamWeaponParticle;
   import alternativa.tanks.models.weapon.streamweapon.StreamWeaponGraphicEffect;
   import alternativa.tanks.utils.objectpool.Pool;
   import alternativa.tanks.utils.objectpool.PooledObject;
   
   public class StreamWeaponParticlesPositionProvider extends PooledObject implements Object3DPositionProvider
   {
      
      private var _streamWeaponGraphicEffect:StreamWeaponGraphicEffect;
      
      private var _defaultPositionProvider:CollisionObject3DPositionProvider;
      
      private var weightDistance:Array = [0.1,0.3,0.5,0.8,0.9,1];
      
      private var weightValue:Array = [0.5,0.8,1,0.5,0.3,0.05];
      
      public function StreamWeaponParticlesPositionProvider(param1:Pool)
      {
         super(param1);
      }
      
      public function init(param1:StreamWeaponGraphicEffect, param2:CollisionObject3DPositionProvider) : void
      {
         this._streamWeaponGraphicEffect = param1;
         this._defaultPositionProvider = param2;
      }
      
      public function initPosition(param1:Object3D) : void
      {
         var _loc6_:Vector.<StreamWeaponParticle> = null;
         var _loc7_:int = 0;
         var _loc8_:StreamWeaponParticle = null;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc2_:Number = 0;
         var _loc3_:Number = 0;
         var _loc4_:Number = 0;
         var _loc5_:Number = 0;
         if(this._streamWeaponGraphicEffect.numParticles == 0)
         {
            this._defaultPositionProvider.initPosition(param1);
         }
         else
         {
            _loc6_ = this._streamWeaponGraphicEffect.particles;
            _loc7_ = 0;
            while(_loc7_ < this._streamWeaponGraphicEffect.numParticles)
            {
               _loc8_ = _loc6_[_loc7_];
               _loc9_ = _loc8_.particleDistance / this._streamWeaponGraphicEffect.range;
               _loc10_ = this.getWeight(_loc9_);
               _loc5_ += _loc10_;
               _loc2_ += _loc8_.x * _loc10_;
               _loc3_ += _loc8_.y * _loc10_;
               _loc4_ += _loc8_.z * _loc10_;
               _loc7_++;
            }
            _loc2_ /= _loc5_;
            _loc3_ /= _loc5_;
            _loc4_ /= _loc5_;
            param1.x = _loc2_;
            param1.y = _loc3_;
            param1.z = _loc4_;
         }
      }
      
      private function getWeight(param1:Number) : Number
      {
         var _loc3_:Number = NaN;
         var _loc2_:int = 0;
         while(_loc2_ < this.weightDistance.length)
         {
            _loc3_ = Number(this.weightDistance[_loc2_]);
            if(_loc3_ >= param1)
            {
               return this.weightValue[_loc2_];
            }
            _loc2_++;
         }
         return 0;
      }
      
      public function updateObjectPosition(param1:Object3D, param2:GameCamera, param3:int) : void
      {
         this.initPosition(param1);
      }
      
      public function destroy() : void
      {
         this._streamWeaponGraphicEffect = null;
         this._defaultPositionProvider = null;
      }
   }
}

