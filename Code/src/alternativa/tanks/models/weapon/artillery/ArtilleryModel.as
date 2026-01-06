package alternativa.tanks.models.weapon.artillery
{
   import alternativa.tanks.battle.BattleUtils;
   import alternativa.tanks.battle.objects.tank.Weapon;
   import alternativa.tanks.battle.objects.tank.controllers.LocalTurretController;
   import alternativa.tanks.battle.objects.tank.controllers.LocalTurretControllerFactory;
   import alternativa.tanks.battle.objects.tank.controllers.TurretController;
   import alternativa.tanks.battle.objects.tank.tankskin.turret.ArtilleryHorizontalTurretSkin;
   import alternativa.tanks.battle.objects.tank.tankskin.turret.ArtilleryTurretSkin;
   import alternativa.tanks.battle.objects.tank.tankskin.turret.CustomTurretSkin;
   import alternativa.tanks.battle.objects.tank.tankskin.turret.TurretSkin;
   import alternativa.tanks.models.tank.event.LocalTankUnloadListener;
   import alternativa.tanks.models.weapon.IWeaponModel;
   import alternativa.tanks.models.weapon.artillery.rotation.ArtilleryRotatingTurretModel;
   import alternativa.tanks.models.weapon.artillery.sfx.ArtilleryEffects;
   import alternativa.tanks.models.weapon.artillery.turretcontroller.ArtilleryLocalTurretController;
   import alternativa.tanks.models.weapons.charging.WeaponChargingListener;
   import alternativa.tanks.utils.MathUtils;
   import platform.client.fp10.core.model.ObjectLoadListener;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battlefield.models.tankparts.weapons.artillery.ArtilleryCC;
   import projects.tanks.client.battlefield.models.tankparts.weapons.artillery.ArtilleryModelBase;
   import projects.tanks.client.battlefield.models.tankparts.weapons.artillery.IArtilleryModelBase;
   import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;
   
   [ModelInfo]
   public class ArtilleryModel extends ArtilleryModelBase implements IArtilleryModelBase, ArtillerySkin, ArtilleryEffectsProvider, IWeaponModel, WeaponChargingListener, ObjectLoadListener, LocalTurretControllerFactory, LocalTankUnloadListener, CustomTurretSkin
   {
      
      public function ArtilleryModel()
      {
         super();
      }
      
      public function objectLoaded() : void
      {
         var _loc1_:ArtilleryCC = getInitParam();
         _loc1_.shellRadius = BattleUtils.toClientScale(_loc1_.shellRadius);
         _loc1_.minShellSpeed = BattleUtils.toClientScale(_loc1_.minShellSpeed);
         _loc1_.maxShellSpeed = BattleUtils.toClientScale(_loc1_.maxShellSpeed);
         _loc1_.initialTurretAngle = -MathUtils.toRadians(_loc1_.initialTurretAngle);
      }
      
      public function createLocalWeapon(param1:IGameObject) : Weapon
      {
         var _loc2_:ArtilleryObject = new ArtilleryObject(object);
         putData(ArtilleryEffects,new ArtilleryEffects(_loc2_));
         var _loc3_:ArtilleryWeapon = new ArtilleryWeapon(param1,_loc2_,getInitParam());
         if(!this.isHorizontalRotation())
         {
            this.setInitialTurretDirection(_loc2_);
            putData(VerticalAngleView,new VerticalAngleView(param1,_loc3_));
         }
         else
         {
            _loc2_.weaponCommon().getTurretController().clearRotationLimits();
         }
         return _loc3_;
      }
      
      public function createRemoteWeapon(param1:IGameObject) : Weapon
      {
         var _loc2_:ArtilleryObject = new ArtilleryObject(object);
         _loc2_.markAsRemote();
         if(!this.isHorizontalRotation())
         {
            this.setInitialTurretDirection(_loc2_);
         }
         else
         {
            _loc2_.weaponCommon().getTurretController().clearRotationLimits();
         }
         putData(ArtilleryEffects,new ArtilleryEffects(_loc2_));
         var _loc3_:RemoteArtilleryWeapon = new RemoteArtilleryWeapon(param1,_loc2_,getInitParam());
         putData(RemoteArtilleryWeapon,_loc3_);
         return _loc3_;
      }
      
      private function setInitialTurretDirection(param1:ArtilleryObject) : void
      {
         param1.weaponCommon().getTurretController().setInitialDirection(getInitParam().initialTurretAngle);
      }
      
      public function handleChargingStart(param1:int) : void
      {
         this.remoteWeapon().startCharging(param1);
      }
      
      public function handleChargingFinish(param1:int) : void
      {
         this.remoteWeapon().shoot(param1);
      }
      
      public function createLocalTurretController(param1:TurretController) : LocalTurretController
      {
         return new ArtilleryLocalTurretController(param1);
      }
      
      public function createSkin(param1:Tanks3DSResource) : TurretSkin
      {
         var _loc2_:ArtilleryTurretSkin = null;
         if(this.isHorizontalRotation())
         {
            _loc2_ = new ArtilleryHorizontalTurretSkin(getInitParam().initialTurretAngle,param1);
         }
         else
         {
            _loc2_ = new ArtilleryTurretSkin(param1);
         }
         putData(ArtilleryTurretSkin,_loc2_);
         return _loc2_;
      }
      
      public function getSkin() : ArtilleryTurretSkin
      {
         return ArtilleryTurretSkin(getData(ArtilleryTurretSkin));
      }
      
      private function remoteWeapon() : RemoteArtilleryWeapon
      {
         return RemoteArtilleryWeapon(getData(RemoteArtilleryWeapon));
      }
      
      public function getArtilleryEffects() : ArtilleryEffects
      {
         return ArtilleryEffects(getData(ArtilleryEffects));
      }
      
      public function localTankUnloaded(param1:Boolean) : void
      {
         if(!this.isHorizontalRotation())
         {
            VerticalAngleView(getData(VerticalAngleView)).close();
         }
         ArtilleryEffects(getData(ArtilleryEffects)).close();
      }
      
      private function isHorizontalRotation() : Boolean
      {
         return object.hasModel(ArtilleryRotatingTurretModel);
      }
   }
}

