package alternativa.tanks.models.weapon.thunder
{
   import alternativa.math.Vector3;
   import alternativa.physics.Body;
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.battle.BattleUtils;
   import alternativa.tanks.battle.events.BattleEventDispatcher;
   import alternativa.tanks.battle.events.BattleEventListener;
   import alternativa.tanks.battle.events.BattleEventSupport;
   import alternativa.tanks.battle.events.StateCorrectionEvent;
   import alternativa.tanks.battle.events.TankUnloadedEvent;
   import alternativa.tanks.battle.objects.tank.Tank;
   import alternativa.tanks.battle.objects.tank.Weapon;
   import alternativa.tanks.models.tank.ITankModel;
   import alternativa.tanks.models.weapon.IWeaponModel;
   import alternativa.tanks.models.weapon.WeaponForces;
   import alternativa.tanks.models.weapon.WeaponObject;
   import alternativa.tanks.models.weapon.common.IWeaponCommonModel;
   import alternativa.tanks.models.weapon.common.WeaponCommonData;
   import alternativa.tanks.models.weapon.splash.Splash;
   import alternativa.tanks.models.weapon.weakening.DistanceWeakening;
   import alternativa.tanks.models.weapon.weakening.IWeaponWeakeningModel;
   import alternativa.tanks.models.weapons.targeting.CommonTargetingSystem;
   import alternativa.tanks.models.weapons.targeting.TargetingSystem;
   import flash.utils.Dictionary;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battlefield.models.tankparts.weapon.thunder.IThunderModelBase;
   import projects.tanks.client.battlefield.models.tankparts.weapon.thunder.ThunderModelBase;
   import projects.tanks.client.battlefield.types.Vector3d;
   import alternativa.tanks.models.weapons.targeting.CheatCommonTargetingSystem;
   
   [ModelInfo]
   public class ThunderModel extends ThunderModelBase implements IThunderModelBase, IWeaponModel, BattleEventListener, ThunderCallback
   {
      
      [Inject] // added
      public static var battleService:BattleService;
      
      [Inject] // added
      public static var battleEventDispatcher:BattleEventDispatcher;
      
      private static const MAX_DISTANCE:Number = 1000000;
      
      private var weapons:Dictionary = new Dictionary();
      
      private var battleEventSupport:BattleEventSupport;
      
      public function ThunderModel()
      {
         super();
         this.battleEventSupport = new BattleEventSupport(battleEventDispatcher,this);
         this.battleEventSupport.addEventHandler(TankUnloadedEvent,this.onTankUnloaded);
         this.battleEventSupport.activateHandlers();
      }
      
      private static function getCommonData() : WeaponCommonData
      {
         var _loc1_:IWeaponCommonModel = IWeaponCommonModel(object.adapt(IWeaponCommonModel));
         return _loc1_.getCommonData();
      }
      
      private static function getWeakening() : DistanceWeakening
      {
         var _loc1_:IWeaponWeakeningModel = IWeaponWeakeningModel(object.adapt(IWeaponWeakeningModel));
         return _loc1_.getDistanceWeakening();
      }
      
      private static function getEffects() : IThunderEffects
      {
         var _loc1_:IThunderSFXModel = IThunderSFXModel(object.adapt(IThunderSFXModel));
         return _loc1_.getEffects();
      }
      
      public function handleBattleEvent(param1:Object) : void
      {
         this.battleEventSupport.handleBattleEvent(param1);
      }
      
      public function createLocalWeapon(param1:IGameObject) : Weapon
      {
         var _loc2_:WeaponObject = new WeaponObject(object);
         var _loc3_:WeaponCommonData = _loc2_.commonData();
         var _loc4_:DistanceWeakening = getWeakening();
         var _loc5_:Splash = Splash(object.adapt(Splash));
         var _loc6_:IThunderEffects = getEffects();
         var targetingSystem:TargetingSystem = new CommonTargetingSystem(param1,_loc2_,MAX_DISTANCE);
         var cheatTargetingSystem:TargetingSystem = new CheatCommonTargetingSystem(param1,_loc2_,MAX_DISTANCE);
         var _loc8_:WeaponForces = new WeaponForces(_loc3_.getImpactForce(),_loc3_.getRecoilForce());
         var _loc9_:Weapon = new ThunderWeapon(_loc2_.getReloadTimeMS(),_loc8_,_loc4_,targetingSystem,cheatTargetingSystem,_loc5_,_loc6_,ThunderCallback(object.adapt(ThunderCallback)));
         this.weapons[param1] = _loc9_;
         return _loc9_;
      }
      
      public function createRemoteWeapon(param1:IGameObject) : Weapon
      {
         var _loc2_:WeaponCommonData = getCommonData();
         var _loc3_:DistanceWeakening = getWeakening();
         var _loc4_:IThunderEffects = getEffects();
         var _loc5_:Splash = Splash(object.adapt(Splash));
         var _loc6_:WeaponForces = new WeaponForces(_loc2_.getImpactForce(),_loc2_.getRecoilForce());
         var _loc7_:Weapon = new RemoteThunderWeapon(_loc6_,_loc3_,_loc5_,_loc4_);
         this.weapons[param1] = _loc7_;
         return _loc7_;
      }
      
      private function onTankUnloaded(param1:TankUnloadedEvent) : void
      {
         delete this.weapons[param1.tank.getUser()];
      }
      
      [Obfuscation(rename="false")]
      public function shoot(param1:IGameObject) : void
      {
         var _loc2_:RemoteThunderWeapon = this.weapons[param1];
         if(_loc2_ != null)
         {
            _loc2_.shoot();
         }
      }
      
      [Obfuscation(rename="false")]
      public function shootStatic(param1:IGameObject, param2:Vector3d) : void
      {
         var _loc3_:RemoteThunderWeapon = this.weapons[param1];
         if(_loc3_ != null)
         {
            _loc3_.shootStatic(BattleUtils.getVector3(param2));
         }
      }
      
      [Obfuscation(rename="false")]
      public function shootTarget(param1:IGameObject, param2:IGameObject, param3:Vector3d) : void
      {
         var _loc5_:ITankModel = null;
         var _loc6_:Tank = null;
         var _loc7_:Vector3 = null;
         var _loc4_:RemoteThunderWeapon = this.weapons[param1];
         if(_loc4_ != null)
         {
            _loc5_ = ITankModel(param2.adapt(ITankModel));
            _loc6_ = _loc5_.getTank();
            if(_loc6_.getBody() != null)
            {
               _loc7_ = BattleUtils.getVector3(param3);
               BattleUtils.localToGlobal(_loc6_.getBody(),_loc7_);
               _loc4_.shootTarget(_loc6_,_loc7_);
            }
         }
      }
      
      public function onShot(param1:int) : void
      {
         server.shootCommand(param1);
      }
      
      public function onShotStatic(param1:int, param2:Vector3) : void
      {
         this.battleEventSupport.dispatchEvent(StateCorrectionEvent.MANDATORY_UPDATE);
         server.shootStaticCommand(param1,BattleUtils.getVector3d(param2));
      }
      
      public function onShotTarget(param1:int, param2:Vector3, param3:Body) : void
      {
         var _loc4_:Vector3 = param2.clone();
         BattleUtils.globalToLocal(param3,_loc4_);
         var _loc5_:Vector3d = BattleUtils.getVector3d(_loc4_);
         var _loc6_:Tank = param3.tank;
         var _loc7_:int = _loc6_.incarnation;
         var _loc8_:Vector3d = BattleUtils.getVector3d(param3.state.position);
         this.battleEventSupport.dispatchEvent(StateCorrectionEvent.MANDATORY_UPDATE);
         server.shootTargetCommand(param1,_loc5_,_loc6_.getUser(),_loc7_,_loc8_,BattleUtils.getVector3d(param2));
      }
   }
}

