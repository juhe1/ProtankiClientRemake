package alternativa.tanks.models.weapon.shotgun
{
   import alternativa.math.Vector3;
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.battle.BattleUtils;
   import alternativa.tanks.battle.objects.tank.Tank;
   import alternativa.tanks.battle.objects.tank.Weapon;
   import alternativa.tanks.models.tank.DummyWeapon;
   import alternativa.tanks.models.tank.ITankModel;
   import alternativa.tanks.models.weapon.AllGlobalGunParams;
   import alternativa.tanks.models.weapon.IWeaponModel;
   import alternativa.tanks.models.weapon.WeaponObject;
   import alternativa.tanks.models.weapon.WeaponUtils;
   import alternativa.tanks.models.weapon.shotgun.aiming.ShotgunAiming;
   import alternativa.tanks.models.weapon.shotgun.sfx.ShotgunEffects;
   import alternativa.tanks.models.weapon.shotgun.sfx.ShotgunSFX;
   import alternativa.tanks.models.weapon.weakening.DistanceWeakening;
   import alternativa.tanks.models.weapons.discrete.DiscreteWeaponListener;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battlefield.models.tankparts.weapons.common.discrete.TargetHit;
   import projects.tanks.client.battlefield.models.tankparts.weapons.shotgun.shot.IShotgunShotModelBase;
   import projects.tanks.client.battlefield.models.tankparts.weapons.shotgun.shot.ShotgunShotModelBase;
   
   [ModelInfo]
   public class ShotgunModel extends ShotgunShotModelBase implements IShotgunShotModelBase, IWeaponModel, DiscreteWeaponListener
   {
      
      [Inject] // added
      public static var battleService:BattleService;
      
      private var shooter:IGameObject;
      
      private var gunParams:AllGlobalGunParams = new AllGlobalGunParams();
      
      private var weapon:ShotgunWeapon;
      
      public function ShotgunModel()
      {
         super();
      }
      
      private static function getEffects() : ShotgunEffects
      {
         var _loc1_:ShotgunSFX = ShotgunSFX(object.adapt(ShotgunSFX));
         return _loc1_.getEffects();
      }
      
      public function createLocalWeapon(param1:IGameObject) : Weapon
      {
         this.shooter = param1;
         this.weapon = new ShotgunWeapon(getInitParam(),new ShotgunObject(object),this.aiming().createTargetingSystem(),getEffects());
         return this.weapon;
      }
      
      public function createRemoteWeapon(param1:IGameObject) : Weapon
      {
         return new DummyWeapon();
      }
      
      public function onShot(param1:IGameObject, param2:Vector3, param3:Vector.<TargetHit>) : void
      {
         this.calculateGunParams(param1);
         this.applyImpact(param3);
      }
      
      private function aiming() : ShotgunAiming
      {
         return ShotgunAiming(object.adapt(ShotgunAiming));
      }
      
      private function calculateGunParams(param1:IGameObject) : void
      {
         var _loc2_:ITankModel = ITankModel(param1.adapt(ITankModel));
         var _loc3_:Tank = _loc2_.getTank();
         WeaponUtils.calculateMainGunParams(_loc3_.getTurret3D(),_loc3_.getLocalMuzzlePosition(),this.gunParams);
      }
      
      private function applyImpact(param1:Vector.<TargetHit>) : void
      {
         var _loc5_:TargetHit = null;
         var _loc6_:ITankModel = null;
         var _loc7_:Tank = null;
         var _loc8_:Vector3 = null;
         var _loc9_:Number = NaN;
         var _loc2_:WeaponObject = new WeaponObject(object);
         var _loc3_:Number = _loc2_.commonData().getImpactForce();
         var _loc4_:DistanceWeakening = _loc2_.distanceWeakening();
         for each(_loc5_ in param1)
         {
            _loc6_ = ITankModel(_loc5_.target.adapt(ITankModel));
            _loc7_ = _loc6_.getTank();
            _loc8_ = BattleUtils.getVector3(_loc5_.localHitPoint);
            BattleUtils.localToGlobal(_loc7_.getBody(),_loc8_);
            _loc9_ = _loc4_.getImpactCoeff(_loc8_.distanceTo(this.gunParams.barrelOrigin));
            _loc7_.applyWeaponHit(_loc8_,BattleUtils.getVector3(_loc5_.direction),_loc3_ * _loc9_ * _loc5_.numberHits);
         }
      }
      
      public function setRemainingShots(param1:int) : void
      {
         this.weapon.setRemainingShots(param1);
      }
   }
}

