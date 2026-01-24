package alternativa.tanks.models.weapon.flamethrower
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
   import alternativa.tanks.models.weapon.ConicAreaData;
   import alternativa.tanks.models.weapon.IWeaponModel;
   import alternativa.tanks.models.weapon.shared.ConicAreaTargetingSystem;
   import alternativa.tanks.models.weapon.shared.SimpleWeaponController;
   import alternativa.tanks.models.weapon.shared.streamweapon.IStreamWeaponCallback;
   import alternativa.tanks.models.weapon.shared.streamweapon.StreamWeapon;
   import alternativa.tanks.models.weapon.shared.streamweapon.StreamWeaponEffects;
   import alternativa.tanks.models.weapon.streamweapon.IStreamWeaponModel;
   import alternativa.tanks.models.weapon.streamweapon.StreamConeParams;
   import alternativa.tanks.models.weapon.streamweapon.StreamWeaponData;
   import alternativa.tanks.physics.TanksCollisionDetector;
   import flash.utils.Dictionary;
   import platform.client.fp10.core.model.ObjectLoadListener;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battlefield.models.tankparts.weapon.flamethrower.FlameThrowerCC;
   import projects.tanks.client.battlefield.models.tankparts.weapon.flamethrower.FlameThrowerModelBase;
   import projects.tanks.client.battlefield.models.tankparts.weapon.flamethrower.IFlameThrowerModelBase;
   import projects.tanks.client.battlefield.types.Vector3d;
   import projects.tanks.client.garage.models.item.properties.ItemProperty;
   
   [ModelInfo]
   public class FlamethrowerModel extends FlameThrowerModelBase implements IFlameThrowerModelBase, IWeaponModel, IStreamWeaponCallback, ObjectLoadListener, BattleEventListener
   {
      
      [Inject] // added
      public static var battleService:BattleService;
      
      [Inject] // added
      public static var battleEventDispatcher:BattleEventDispatcher;
      
      private const targets:Vector.<IGameObject> = new Vector.<IGameObject>();
      
      private const targetIncarnations:Vector.<int> = new Vector.<int>();
      
      private var localUser:IGameObject;
      
      private var weapons:Dictionary = new Dictionary();
      
      private var battleEventSupport:BattleEventSupport;
      
      public function FlamethrowerModel()
      {
         super();
         this.battleEventSupport = new BattleEventSupport(battleEventDispatcher,this);
         this.battleEventSupport.addEventHandler(TankUnloadedEvent,this.onTankUnloaded);
         this.battleEventSupport.activateHandlers();
      }
      
      private static function getStreamWeaponData() : StreamWeaponData
      {
         var _loc1_:IStreamWeaponModel = IStreamWeaponModel(object.adapt(IStreamWeaponModel));
         return _loc1_.getStreamWeaponData();
      }
      
      [Obfuscation(rename="false")]
      public function objectLoaded() : void
      {
         var _loc1_:FlameThrowerCC = getInitParam();
         var _loc2_:ConicAreaData = new ConicAreaData(_loc1_.coneAngle,BattleUtils.toClientScale(_loc1_.range));
         putData(ConicAreaData,_loc2_);
      }
      
      [Obfuscation(rename="false")]
      public function startFire(param1:IGameObject) : void
      {
         var _loc2_:RemoteFlamethrower = this.weapons[param1];
         if(_loc2_ != null)
         {
            _loc2_.startFire();
         }
      }
      
      [Obfuscation(rename="false")]
      public function stopFire(param1:IGameObject) : void
      {
         var _loc2_:RemoteFlamethrower = this.weapons[param1];
         if(_loc2_ != null)
         {
            _loc2_.stopFire();
         }
      }
      
      public function handleBattleEvent(param1:Object) : void
      {
         this.battleEventSupport.handleBattleEvent(param1);
      }
      
      private function onTankUnloaded(param1:TankUnloadedEvent) : void
      {
         var _loc2_:IGameObject = param1.tank.getUser();
         if(this.localUser == _loc2_)
         {
            this.localUser = null;
         }
         delete this.weapons[_loc2_];
      }
      
      public function createLocalWeapon(param1:IGameObject) : Weapon
      {
         this.localUser = param1;
         var _loc2_:TanksCollisionDetector = battleService.getBattleRunner().getCollisionDetector();
         var _loc3_:ConicAreaData = ConicAreaData(getData(ConicAreaData));
         var _loc4_:ConicAreaTargetingSystem = new ConicAreaTargetingSystem(_loc3_.getRange(),_loc3_.getConeAngle(),StreamConeParams.NUM_RADIAL_RAYS,StreamConeParams.NUM_STEPS,_loc2_,battleService.getConicAreaTargetValidator());
         var _loc5_:SimpleWeaponController = new SimpleWeaponController();
         var _loc6_:StreamWeaponData = getStreamWeaponData();
         var _loc7_:Number = _loc6_.getEnergyCapacity();
         var _loc8_:Number = _loc6_.getEnergyDischargeSpeed();
         var _loc9_:Number = _loc6_.getEnergyRechargeSpeed();
         var _loc10_:Weapon = new StreamWeapon(_loc7_,_loc8_,_loc9_,_loc6_.getTickIntervalMsec(),_loc4_,_loc5_,IStreamWeaponCallback(object.adapt(IStreamWeaponCallback)),this.getEffects(),ItemProperty.FIREBIRD_RESISTANCE);
         this.weapons[param1] = _loc10_;
         return _loc10_;
      }
      
      private function getEffects() : StreamWeaponEffects
      {
         var _loc1_:ConicAreaData = ConicAreaData(getData(ConicAreaData));
         var _loc2_:IFlamethrowerSFXModel = IFlamethrowerSFXModel(object.adapt(IFlamethrowerSFXModel));
         return _loc2_.getFlamethrowerEffects(_loc1_.getRange(),_loc1_.getConeAngle());
      }
      
      public function createRemoteWeapon(param1:IGameObject) : Weapon
      {
         var _loc2_:Weapon = new RemoteFlamethrower(this.getEffects());
         this.weapons[param1] = _loc2_;
         return _loc2_;
      }
      
      public function start(param1:int) : void
      {
         server.startFireCommand(param1);
      }
      
      public function stop(param1:int) : void
      {
         server.stopFireCommand(param1);
      }
      
      public function onTick(param1:Weapon, param2:Vector.<Body>, param3:Vector.<Number>, param4:Vector.<Vector3>, param5:int) : void
      {
         var _loc6_:Vector.<Vector3d> = null;
         var _loc7_:Vector.<Vector3d> = null;
         var _loc8_:int = 0;
         var _loc9_:Body = null;
         if(param1 == this.weapons[this.localUser])
         {
            this.collectTargetsData(param2);
            _loc6_ = new Vector.<Vector3d>(param2.length);
            _loc7_ = new Vector.<Vector3d>(param2.length);
            _loc8_ = 0;
            while(_loc8_ < param2.length)
            {
               _loc9_ = param2[_loc8_];
               _loc6_[_loc8_] = BattleUtils.getVector3d(_loc9_.state.position);
               _loc7_[_loc8_] = BattleUtils.getVector3d(param4[_loc8_]);
               _loc8_++;
            }
            this.battleEventSupport.dispatchEvent(StateCorrectionEvent.MANDATORY_UPDATE);
            server.hitCommand(param5,this.targets,this.targetIncarnations,_loc6_,_loc7_);
            this.targets.length = 0;
            this.targetIncarnations.length = 0;
         }
      }
      
      private function collectTargetsData(param1:Vector.<Body>) : void
      {
         var _loc3_:Body = null;
         var _loc4_:Tank = null;
         var _loc2_:int = 0;
         while(_loc2_ < param1.length)
         {
            _loc3_ = Body(param1[_loc2_]);
            _loc4_ = _loc3_.tank;
            this.targets[_loc2_] = _loc4_.getUser();
            this.targetIncarnations[_loc2_] = _loc4_.incarnation;
            _loc2_++;
         }
         this.targets.length = param1.length;
         this.targetIncarnations.length = param1.length;
      }
   }
}

