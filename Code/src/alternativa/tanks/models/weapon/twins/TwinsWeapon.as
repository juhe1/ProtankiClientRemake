package alternativa.tanks.models.weapon.twins
{
   import alternativa.math.Vector3;
   import alternativa.physics.collision.types.RayHit;
   import alternativa.tanks.battle.BattleRunnerProvider;
   import alternativa.tanks.battle.BattleUtils;
   import alternativa.tanks.battle.LogicUnit;
   import alternativa.tanks.battle.objects.tank.Weapon;
   import alternativa.tanks.battle.objects.tank.WeaponPlatform;
   import alternativa.tanks.models.weapon.AllGlobalGunParams;
   import alternativa.tanks.models.weapon.WeaponObject;
   import alternativa.tanks.models.weapon.common.WeaponCommonData;
   import alternativa.tanks.models.weapon.shared.SimpleWeaponController;
   import alternativa.tanks.models.weapon.weakening.DistanceWeakening;
   import alternativa.tanks.models.weapons.targeting.CommonTargetingSystem;
   import alternativa.tanks.models.weapons.targeting.TargetingResult;
   import alternativa.tanks.models.weapons.targeting.TargetingSystem;
   import alternativa.tanks.physics.CollisionGroup;
   import flash.utils.getTimer;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battlefield.models.tankparts.weapon.twins.TwinsCC;
   import projects.tanks.client.garage.models.item.properties.ItemProperty;
   
   public class TwinsWeapon extends BattleRunnerProvider implements Weapon, LogicUnit
   {
      
      private static var shotId:int;
      
      private static const allGunParams:AllGlobalGunParams = new AllGlobalGunParams();
      
      private static const shotDirection:Vector3 = new Vector3();
      
      private static const rayHit:RayHit = new RayHit();
      
      private var nextReadyTime:int;
      
      private var reloadingTime:int;
      
      private var recoilForce:Number;
      
      private var controller:SimpleWeaponController;
      
      private var weaponPlatform:WeaponPlatform;
      
      private var enabled:Boolean;
      
      private var targetingSystem:TargetingSystem;
      
      private var currentBarrel:int;
      
      private var callback:TwinsWeaponCallback;
      
      private var ammunition:TwinsAmmunition;
      
      private var effects:TwinsEffects;
      
      private var weakening:DistanceWeakening;
      
      public function TwinsWeapon(param1:IGameObject, param2:IGameObject, param3:TwinsCC)
      {
         super();
         var _loc4_:WeaponObject = new WeaponObject(param2);
         var _loc5_:DistanceWeakening = _loc4_.distanceWeakening();
         var _loc6_:WeaponCommonData = _loc4_.commonData();
         var _loc7_:TwinsWeaponCallback = TwinsWeaponCallback(param2.adapt(TwinsWeaponCallback));
         var _loc8_:ITwinsSFXModel = ITwinsSFXModel(param2.adapt(ITwinsSFXModel));
         var _loc9_:TwinsAmmunition = new TwinsAmmunition(_loc4_,param3,_loc8_.getSFXData(),_loc7_);
         var _loc10_:TargetingSystem = new CommonTargetingSystem(param1,_loc4_,_loc5_.getDistance());
         _loc10_.getProcessor().setShotFromMuzzle();
         var _loc11_:SimpleWeaponController = new SimpleWeaponController();
         this.reloadingTime = _loc4_.getReloadTimeMS();
         this.recoilForce = _loc6_.getRecoilForce();
         this.controller = _loc11_;
         this.targetingSystem = _loc10_;
         this.callback = _loc7_;
         this.ammunition = _loc9_;
         this.effects = _loc8_.getPlasmaWeaponEffects();
         this.weakening = _loc5_;
      }
      
      public function init(param1:WeaponPlatform) : void
      {
         this.weaponPlatform = param1;
         this.controller.init();
      }
      
      public function destroy() : void
      {
         this.targetingSystem = null;
         this.effects = null;
         this.controller.destroy();
         this.controller = null;
      }
      
      public function activate() : void
      {
         getBattleRunner().addLogicUnit(this);
      }
      
      public function deactivate() : void
      {
         getBattleRunner().removeLogicUnit(this);
      }
      
      public function enable() : void
      {
         if(!this.enabled)
         {
            this.enabled = true;
            this.controller.discardStoredAction();
         }
      }
      
      public function disable(param1:Boolean) : void
      {
         this.enabled = false;
      }
      
      public function reset() : void
      {
         this.controller.discardStoredAction();
         this.nextReadyTime = 0;
         this.currentBarrel = 0;
      }
      
      public function getStatus() : Number
      {
         var _loc1_:Number = 1 - (this.nextReadyTime - getTimer()) / this.reloadingTime;
         return _loc1_ > 1 ? 1 : _loc1_;
      }
      
      public function runLogic(param1:int, param2:int) : void
      {
         if(this.enabled)
         {
            if(this.controller.wasActive() && param1 >= this.nextReadyTime)
            {
               this.shoot(param1);
            }
         }
         this.controller.discardStoredAction();
      }
      
      private function shoot(param1:int) : void
      {
         this.nextReadyTime = param1 + this.reloadingTime;
         this.weaponPlatform.getAllGunParams(allGunParams,this.currentBarrel);
         this.weaponPlatform.getBody().addWorldForceScaled(allGunParams.muzzlePosition,allGunParams.direction,-this.recoilForce);
         this.weaponPlatform.addDust(1);
         this.effects.createShotEffects(this.weaponPlatform.getTurret3D(),this.weaponPlatform.getLocalMuzzlePosition(this.currentBarrel));
         if(BattleUtils.isTurretAboveGround(this.weaponPlatform.getBody(),allGunParams))
         {
            this.doRealShot(param1,allGunParams);
         }
         else
         {
            this.doDummyShot(param1);
         }
         this.currentBarrel = (this.currentBarrel + 1) % this.weaponPlatform.getNumberOfBarrels();
      }
      
      private function doRealShot(param1:int, param2:AllGlobalGunParams) : void
      {
         var _loc4_:TargetingResult = null;
         if(this.barrelCollidesWithStatic(param2.barrelOrigin,param2.direction,this.weaponPlatform.getBarrelLength(this.currentBarrel)))
         {
            shotDirection.copy(param2.direction);
         }
         else
         {
            _loc4_ = this.targetingSystem.target(param2);
            shotDirection.copy(_loc4_.getDirection());
         }
         var _loc3_:TwinsShot = this.ammunition.getShot();
         _loc3_.addToGame(param2,shotDirection,this.weaponPlatform.getBody(),false,++shotId);
         this.callback.onShot(param1,_loc3_.getShotId(),this.currentBarrel,shotDirection);
      }
      
      private function barrelCollidesWithStatic(param1:Vector3, param2:Vector3, param3:Number) : Boolean
      {
         return getBattleRunner().getCollisionDetector().raycastStatic(param1,param2,CollisionGroup.STATIC,param3,null,rayHit);
      }
      
      private function doDummyShot(param1:int) : void
      {
         this.callback.onDummyShot(param1,this.currentBarrel);
      }
      
      public function getResistanceProperty() : ItemProperty
      {
         return ItemProperty.TWINS_RESISTANCE;
      }
   }
}

