package alternativa.tanks.models.weapon.railgun
{
   import alternativa.math.Vector3;
   import alternativa.physics.Body;
   import alternativa.physics.collision.types.RayHit;
   import alternativa.tanks.battle.objects.tank.Tank;
   import alternativa.tanks.battle.objects.tank.Weapon;
   import alternativa.tanks.battle.objects.tank.WeaponPlatform;
   import alternativa.tanks.models.weapon.AllGlobalGunParams;
   import alternativa.tanks.models.weapon.BasicGlobalGunParams;
   import alternativa.tanks.models.weapon.WeaponForces;
   import alternativa.tanks.physics.CollisionGroup;
   import projects.tanks.client.garage.models.item.properties.ItemProperty;
   
   public class RemoteRailgunWeapon implements Weapon
   {
      
      private static const allGunParams:AllGlobalGunParams = new AllGlobalGunParams();
      
      private static const basicGunParams:BasicGlobalGunParams = new BasicGlobalGunParams();
      
      private var effects:IRailgunEffects;
      
      private var weaponPlatform:WeaponPlatform;
      
      private var railgunData:RailgunData;
      
      private var weaponForces:WeaponForces;
      
      public function RemoteRailgunWeapon(param1:WeaponForces, param2:RailgunData, param3:IRailgunEffects)
      {
         super();
         this.weaponForces = param1;
         this.railgunData = param2;
         this.effects = param3;
      }
      
      public function init(param1:WeaponPlatform) : void
      {
         this.weaponPlatform = param1;
      }
      
      public function destroy() : void
      {
         this.effects.stopEffects();
      }
      
      public function activate() : void
      {
      }
      
      public function deactivate() : void
      {
         this.effects.stopEffects();
      }
      
      public function enable() : void
      {
      }
      
      public function disable(param1:Boolean) : void
      {
         this.effects.stopEffects();
      }
      
      public function reset() : void
      {
         this.effects.stopEffects();
      }
      
      public function getStatus() : Number
      {
         return 0;
      }
      
      public function startCharging() : void
      {
         this.effects.createChargeEffect(this.weaponPlatform.getLocalMuzzlePosition(),this.weaponPlatform.getTurret3D(),this.railgunData.getChargingTime());
         this.weaponPlatform.getBasicGunParams(basicGunParams);
         this.effects.createSoundEffect(basicGunParams.muzzlePosition);
      }
      
      public function fire(param1:Vector3, param2:Vector.<Body>, param3:Vector.<Vector3>) : void
      {
         var _loc5_:Vector3 = null;
         var _loc6_:Number = NaN;
         var _loc7_:int = 0;
         var _loc8_:Body = null;
         var _loc9_:Vector3 = null;
         var _loc10_:Tank = null;
         this.weaponPlatform.getAllGunParams(allGunParams);
         this.weaponPlatform.getBody().addWorldForceScaled(allGunParams.muzzlePosition,allGunParams.direction,-this.weaponForces.getRecoilForce());
         this.weaponPlatform.addDust();
         var _loc4_:Vector3 = param1;
         if(param2 != null && param2.length > 0)
         {
            _loc5_ = new Vector3();
            _loc5_.diff(param3[param3.length - 1],allGunParams.barrelOrigin).normalize();
            if(Vector3.isFiniteVector(_loc5_))
            {
               if(_loc4_ == null)
               {
                  _loc4_ = RailgunUtils.getDistantPoint(allGunParams.barrelOrigin,_loc5_);
               }
               _loc6_ = 1;
               _loc7_ = 0;
               while(_loc7_ < param2.length)
               {
                  _loc8_ = param2[_loc7_];
                  if(_loc8_ != null && _loc8_.tank != null)
                  {
                     _loc9_ = param3[_loc7_];
                     if(Vector3.isFiniteVector(_loc9_))
                     {
                        _loc10_ = _loc8_.tank;
                        _loc10_.applyWeaponHit(_loc9_,_loc5_,this.weaponForces.getImpactForce() * _loc6_);
                     }
                  }
                  _loc6_ *= this.railgunData.getWeakeningCoeff();
                  _loc7_++;
               }
            }
            this.effects.createTargetHitEffects(allGunParams.muzzlePosition,param3[param3.length - 1],param3,param2);
         }
         this.effects.createShotTrail(allGunParams.muzzlePosition,_loc4_,allGunParams.direction);
         if(param1 != null)
         {
            this.effects.createStaticHitMark(allGunParams.barrelOrigin,param1);
            this.effects.createStaticHitEffect(allGunParams.muzzlePosition,param1,this.getStaticHitPointNormal(allGunParams.muzzlePosition,param1));
         }
      }
      
      private function getStaticHitPointNormal(param1:Vector3, param2:Vector3) : Vector3
      {
         var _loc3_:Vector3 = param2.clone();
         _loc3_.subtract(param1).normalize();
         var _loc4_:Vector3 = param2.clone();
         _loc4_.subtract(_loc3_);
         var _loc5_:RayHit = new RayHit();
         if(this.weaponPlatform.getBody().scene.collisionDetector.raycastStatic(_loc4_,_loc3_,CollisionGroup.STATIC,100,null,_loc5_))
         {
            return _loc5_.normal;
         }
         _loc3_.reverse();
         return _loc3_;
      }
      
      public function fireDummy() : void
      {
         this.weaponPlatform.getAllGunParams(allGunParams);
         this.weaponPlatform.getBody().addWorldForceScaled(allGunParams.muzzlePosition,allGunParams.direction,-this.weaponForces.getRecoilForce());
         this.weaponPlatform.addDust();
      }
      
      public function getResistanceProperty() : ItemProperty
      {
         return ItemProperty.RAILGUN_RESISTANCE;
      }
   }
}

