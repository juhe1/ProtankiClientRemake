package alternativa.tanks.models.weapon.terminator
{
   import alternativa.math.Vector3;
   import alternativa.physics.Body;
   import alternativa.physics.collision.types.RayHit;
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.battle.objects.tank.Tank;
   import alternativa.tanks.battle.objects.tank.Weapon;
   import alternativa.tanks.battle.objects.tank.WeaponPlatform;
   import alternativa.tanks.models.weapon.AllGlobalGunParams;
   import alternativa.tanks.models.weapon.WeaponForces;
   import alternativa.tanks.models.weapon.laser.LaserPointer;
   import alternativa.tanks.models.weapon.railgun.RailgunData;
   import alternativa.tanks.models.weapon.railgun.RailgunUtils;
   import alternativa.tanks.models.weapon.rocketlauncher.Rocket;
   import alternativa.tanks.models.weapon.rocketlauncher.weapon.salvo.RocketTargetPoint;
   import alternativa.tanks.physics.CollisionGroup;
   import projects.tanks.client.garage.models.item.properties.ItemProperty;
   
   public class RemoteTerminatorWeapon implements Weapon
   {
      
      [Inject]
      public static var battleService:BattleService;
      
      private static const gunParams:AllGlobalGunParams = new AllGlobalGunParams();
      
      private var _commonWeapon:TerminatorCommonWeapon;
      
      private var weaponPlatform:WeaponPlatform;
      
      private var target:RocketTargetPoint = new RocketTargetPoint();
      
      private var railgunData:RailgunData;
      
      private var weaponForces:WeaponForces;
      
      public function RemoteTerminatorWeapon(param1:TerminatorCommonWeapon, param2:WeaponForces, param3:RailgunData)
      {
         super();
         this._commonWeapon = param1;
         this.weaponForces = param2;
         this.railgunData = param3;
      }
      
      public function init(param1:WeaponPlatform) : void
      {
         this.weaponPlatform = param1;
         this._commonWeapon.init(param1,gunParams);
      }
      
      public function activate() : void
      {
      }
      
      public function enable() : void
      {
      }
      
      public function deactivate() : void
      {
         this.stopEffects();
      }
      
      public function disable(param1:Boolean) : void
      {
         this.stopEffects();
      }
      
      public function reset() : void
      {
         this.stopEffects();
      }
      
      private function stopEffects() : void
      {
         this.commonWeapon.effects.railgunEffects.stopEffects();
         LaserPointer(this.commonWeapon.object.adapt(LaserPointer)).hideLaser();
      }
      
      public function getStatus() : Number
      {
         return 0;
      }
      
      public function getResistanceProperty() : ItemProperty
      {
         return ItemProperty.ROCKET_LAUNCHER_RESISTANCE;
      }
      
      public function createPrimaryShotEffect(param1:Vector3, param2:Vector.<Body>, param3:Vector.<Vector3>, param4:int) : void
      {
         var _loc6_:Vector3 = null;
         var _loc7_:Number = NaN;
         var _loc8_:int = 0;
         var _loc9_:Body = null;
         var _loc10_:Vector3 = null;
         var _loc11_:Tank = null;
         this.commonWeapon.effects.createRecoilEffect(param4);
         this.weaponPlatform.getAllGunParams(gunParams,param4);
         this.weaponPlatform.getBody().addWorldForceScaled(gunParams.muzzlePosition,gunParams.direction,-this.weaponForces.getRecoilForce());
         this.weaponPlatform.addDust();
         var _loc5_:Vector3 = param1;
         if(param2 != null && param2.length > 0)
         {
            _loc6_ = new Vector3();
            _loc6_.diff(param3[param3.length - 1],gunParams.barrelOrigin).normalize();
            if(Vector3.isFiniteVector(_loc6_))
            {
               if(_loc5_ == null)
               {
                  _loc5_ = RailgunUtils.getDistantPoint(gunParams.barrelOrigin,_loc6_);
               }
               _loc7_ = 1;
               _loc8_ = 0;
               while(_loc8_ < param2.length)
               {
                  _loc9_ = param2[_loc8_];
                  if(_loc9_ != null && _loc9_.tank != null)
                  {
                     _loc10_ = param3[_loc8_];
                     if(Vector3.isFiniteVector(_loc10_))
                     {
                        _loc11_ = _loc9_.tank;
                        _loc11_.applyWeaponHit(_loc10_,_loc6_,this.weaponForces.getImpactForce() * _loc7_);
                     }
                  }
                  _loc7_ *= this.railgunData.getWeakeningCoeff();
                  _loc8_++;
               }
            }
            this.commonWeapon.effects.railgunEffects.createTargetHitEffects(gunParams.muzzlePosition,param3[param3.length - 1],param3,param2);
         }
         this.commonWeapon.effects.railgunEffects.createShotTrail(gunParams.muzzlePosition,_loc5_,gunParams.direction);
         if(param1 != null)
         {
            this.commonWeapon.effects.railgunEffects.createStaticHitMark(gunParams.barrelOrigin,param1);
            this.commonWeapon.effects.railgunEffects.createStaticHitEffect(gunParams.muzzlePosition,param1,this.getStaticHitPointNormal(gunParams.muzzlePosition,param1));
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
      
      public function secondaryShoot(param1:int, param2:Vector3, param3:Tank, param4:Vector3) : void
      {
         this.target.setTank(param3);
         this.target.setLocalPoint(param4);
         this.weaponPlatform.getAllGunParams(gunParams,param1);
         this._commonWeapon.createSecondaryShotEffects(param1);
         var _loc5_:Rocket = Rocket(battleService.getObjectPool().getObject(Rocket));
         _loc5_.init(this._commonWeapon.initParam.secondaryCC,this._commonWeapon.weaponObject.rocketLauncherObject,this.target,param1,this._commonWeapon.effects.rocketLauncherEffects);
         _loc5_.addToGame(gunParams,param2,this.weaponPlatform.getBody(),true,-1);
      }
      
      public function secondaryDummyShoot(param1:int) : void
      {
         this.weaponPlatform.getAllGunParams(gunParams,param1);
         this._commonWeapon.createSecondaryShotEffects(param1);
      }
      
      public function get commonWeapon() : TerminatorCommonWeapon
      {
         return this._commonWeapon;
      }
      
      public function destroy() : void
      {
         this._commonWeapon.destroy();
         this._commonWeapon = null;
         this.weaponPlatform = null;
         this.target.resetTarget();
         this.target = null;
      }
      
      public function createPrimaryDummyShotEffect(param1:int) : void
      {
         this.weaponPlatform.getAllGunParams(gunParams,param1);
         this.weaponPlatform.getBody().addWorldForceScaled(gunParams.muzzlePosition,gunParams.direction,-this.weaponForces.getRecoilForce());
         this.weaponPlatform.addDust();
      }
   }
}

