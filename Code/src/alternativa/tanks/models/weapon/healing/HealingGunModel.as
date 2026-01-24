package alternativa.tanks.models.weapon.healing
{
   import alternativa.math.Vector3;
   import alternativa.physics.Body;
   import alternativa.physics.collision.types.RayHit;
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.battle.BattleUtils;
   import alternativa.tanks.battle.events.BattleEventDispatcher;
   import alternativa.tanks.battle.events.BattleEventListener;
   import alternativa.tanks.battle.events.BattleEventSupport;
   import alternativa.tanks.battle.events.StateCorrectionEvent;
   import alternativa.tanks.battle.events.TankAddedToBattleEvent;
   import alternativa.tanks.battle.events.TankRemovedFromBattleEvent;
   import alternativa.tanks.battle.objects.tank.Tank;
   import alternativa.tanks.battle.objects.tank.Weapon;
   import alternativa.tanks.models.weapon.IWeaponModel;
   import alternativa.tanks.models.weapon.shared.SimpleWeaponController;
   import flash.utils.Dictionary;
   import platform.client.fp10.core.model.ObjectLoadListener;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battlefield.models.tankparts.weapon.healing.IIsisModelBase;
   import projects.tanks.client.battlefield.models.tankparts.weapon.healing.IsisCC;
   import projects.tanks.client.battlefield.models.tankparts.weapon.healing.IsisModelBase;
   import projects.tanks.client.battlefield.models.tankparts.weapon.healing.IsisState;
   import projects.tanks.client.battlefield.models.tankparts.weapons.common.discrete.TargetHit;
   import projects.tanks.client.battlefield.types.Vector3d;
   
   [ModelInfo]
   public class HealingGunModel extends IsisModelBase implements IIsisModelBase, BattleEventListener, IWeaponModel, HealingGunCallback, ObjectLoadListener
   {
      
      [Inject] // added
      public static var battleService:BattleService;
      
      [Inject] // added
      public static var battleEventDispatcher:BattleEventDispatcher;
      
      private var tmpVector:Vector3 = new Vector3();
      
      private var localHitPoint:Vector3d = new Vector3d();
      
      private var tanksInBattle:Dictionary = new Dictionary();
      
      private var battleEventSupport:BattleEventSupport;
      
      public function HealingGunModel()
      {
         super();
         this.battleEventSupport = new BattleEventSupport(battleEventDispatcher,this);
         this.battleEventSupport.addEventHandler(TankAddedToBattleEvent,this.onTankAddedToBattle);
         this.battleEventSupport.addEventHandler(TankRemovedFromBattleEvent,this.onTankRemovedFromBattle);
         this.battleEventSupport.activateHandlers();
      }
      
      private static function getEffects() : HealingGunEffects
      {
         var _loc1_:IHealingGunSFXModel = IHealingGunSFXModel(object.adapt(IHealingGunSFXModel));
         return _loc1_.getHealingGunEffects();
      }
      
      [Obfuscation(rename="false")]
      public function objectLoaded() : void
      {
         var _loc1_:IsisCC = getInitParam();
         _loc1_.radius = BattleUtils.toClientScale(_loc1_.radius);
      }
      
      [Obfuscation(rename="false")]
      public function setTarget(param1:IsisState, param2:TargetHit) : void
      {
         this.doStartWeapon(param1,param2);
      }
      
      [Obfuscation(rename="false")]
      public function stopWeapon() : void
      {
         var _loc1_:RemoteHealingGun = this.getRemoteWeapon();
         if(_loc1_ != null)
         {
            _loc1_.stop();
         }
      }
      
      [Obfuscation(rename="false")]
      public function resetTarget() : void
      {
         var _loc1_:RemoteHealingGun = this.getRemoteWeapon();
         _loc1_.resetTarget();
      }
      
      public function createLocalWeapon(param1:IGameObject) : Weapon
      {
         var _loc2_:HealingGunEffects = getEffects();
         var _loc3_:Weapon = new LocalHealingGun(param1,getInitParam(),new SimpleWeaponController(),_loc2_,HealingGunCallback(object.adapt(HealingGunCallback)));
         putData(LocalHealingGun,_loc3_);
         return _loc3_;
      }
      
      public function createRemoteWeapon(param1:IGameObject) : Weapon
      {
         var _loc2_:Weapon = new RemoteHealingGun(getEffects());
         putData(RemoteHealingGun,_loc2_);
         return _loc2_;
      }
      
      public function handleBattleEvent(param1:Object) : void
      {
         this.battleEventSupport.handleBattleEvent(param1);
      }
      
      public function updateHit(param1:int, param2:RayHit) : void
      {
         var _loc3_:Body = null;
         var _loc4_:Tank = null;
         if(param2 != null)
         {
            _loc3_ = param2.shape.body;
            _loc4_ = _loc3_.tank;
            _loc4_.setLastHitPoint(param2.position);
            server.setTarget(param1,_loc4_.getUser(),_loc4_.incarnation,this.getLocalHitPoint(param2));
         }
         else
         {
            server.resetTarget(param1);
         }
      }
      
      public function stop(param1:int) : void
      {
         server.stopWeaponCommand(param1);
      }
      
      public function onTick(param1:int, param2:RayHit) : void
      {
         this.battleEventSupport.dispatchEvent(StateCorrectionEvent.MANDATORY_UPDATE);
         var _loc3_:Body = param2.shape.body;
         var _loc4_:Tank = _loc3_.tank;
         server.tickCommand(param1,_loc4_.incarnation,BattleUtils.getVector3d(_loc3_.state.position),this.getLocalHitPoint(param2));
      }
      
      private function doStartWeapon(param1:IsisState, param2:TargetHit) : void
      {
         var _loc4_:Tank = null;
         var _loc5_:Vector3 = null;
         var _loc6_:Vector3d = null;
         var _loc3_:RemoteHealingGun = this.getRemoteWeapon();
         if(_loc3_ != null)
         {
            if(param1 != IsisState.IDLE)
            {
               if(param2 != null && param2.target != null)
               {
                  _loc4_ = this.tanksInBattle[param2.target.name];
               }
            }
            if(param1 == IsisState.IDLE || _loc4_ != null)
            {
               _loc5_ = this.tmpVector;
               _loc6_ = param2.localHitPoint;
               _loc5_.reset(_loc6_.x,_loc6_.y,_loc6_.z);
               _loc3_.startAction(param1,_loc4_,_loc5_);
            }
            else
            {
               _loc3_.stop();
            }
         }
      }
      
      private function getLocalHitPoint(param1:RayHit) : Vector3d
      {
         var _loc2_:Body = param1.shape.body;
         var _loc3_:Vector3 = BattleUtils.tmpVector;
         _loc3_.copy(param1.position);
         BattleUtils.globalToLocal(_loc2_,_loc3_);
         BattleUtils.copyToVector3d(_loc3_,this.localHitPoint);
         return this.localHitPoint;
      }
      
      private function onTankAddedToBattle(param1:TankAddedToBattleEvent) : void
      {
         this.tanksInBattle[param1.tank.getUserId()] = param1.tank;
      }
      
      private function onTankRemovedFromBattle(param1:TankRemovedFromBattleEvent) : void
      {
         delete this.tanksInBattle[param1.tank.getUserId()];
      }
      
      private function getRemoteWeapon() : RemoteHealingGun
      {
         return RemoteHealingGun(getData(RemoteHealingGun));
      }
      
      public function addEnergy(param1:int) : void
      {
         LocalHealingGun(getData(LocalHealingGun)).addEnergy(param1);
      }
   }
}

