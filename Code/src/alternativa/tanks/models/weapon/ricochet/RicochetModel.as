package alternativa.tanks.models.weapon.ricochet
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
   import alternativa.tanks.models.weapon.IWeaponModel;
   import flash.utils.Dictionary;
   import platform.client.fp10.core.model.ObjectLoadListener;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battlefield.models.tankparts.weapon.ricochet.IRicochetModelBase;
   import projects.tanks.client.battlefield.models.tankparts.weapon.ricochet.RicochetCC;
   import projects.tanks.client.battlefield.models.tankparts.weapon.ricochet.RicochetModelBase;
   
   [ModelInfo]
   public class RicochetModel extends RicochetModelBase implements IRicochetModelBase, ObjectLoadListener, IWeaponModel, RicochetWeaponCallback, BattleEventListener
   {
      
      [Inject]
      public static var battleService:BattleService;
      
      [Inject]
      public static var battleEventDispatcher:BattleEventDispatcher;
      
      private static const shotDirection:Vector3 = new Vector3();
      
      private var battleEventSupport:BattleEventSupport;
      
      private var weapons:Dictionary = new Dictionary();
      
      private var localWeapon:RicochetWeapon;
      
      public function RicochetModel()
      {
         super();
         this.initBattleEventListeners();
      }
      
      private static function clientToServer(param1:Number) : Number
      {
         return param1 * 32767;
      }
      
      private static function serverToClient(param1:Number) : Number
      {
         return param1 / 32767;
      }
      
      private function initBattleEventListeners() : void
      {
         this.battleEventSupport = new BattleEventSupport(battleEventDispatcher,this);
         this.battleEventSupport.addEventHandler(TankUnloadedEvent,this.onTankUnloaded);
         this.battleEventSupport.activateHandlers();
      }
      
      public function handleBattleEvent(param1:Object) : void
      {
         this.battleEventSupport.handleBattleEvent(param1);
      }
      
      [Obfuscation(rename="false")]
      public function fire(param1:IGameObject, param2:int, param3:int, param4:int) : void
      {
         var _loc5_:RemoteRicochetWeapon = this.weapons[param1];
         if(_loc5_ != null)
         {
            shotDirection.reset(serverToClient(param2),serverToClient(param3),serverToClient(param4)).normalize();
            _loc5_.shoot(shotDirection);
         }
      }
      
      [Obfuscation(rename="false")]
      public function fireDummy(param1:IGameObject) : void
      {
         var _loc2_:RemoteRicochetWeapon = this.weapons[param1];
         if(_loc2_ != null)
         {
            _loc2_.shootDummy();
         }
      }
      
      [Obfuscation(rename="false")]
      public function objectLoaded() : void
      {
         var _loc1_:RicochetCC = getInitParam();
         _loc1_.shellRadius = BattleUtils.toClientScale(_loc1_.shellRadius);
         _loc1_.shellSpeed = BattleUtils.toClientScale(_loc1_.shellSpeed);
         _loc1_.shotDistance = BattleUtils.toClientScale(_loc1_.shotDistance);
      }
      
      public function createLocalWeapon(param1:IGameObject) : Weapon
      {
         this.localWeapon = new RicochetWeapon(object,getInitParam());
         this.weapons[param1] = this.localWeapon;
         return this.localWeapon;
      }
      
      public function createRemoteWeapon(param1:IGameObject) : Weapon
      {
         var _loc2_:Weapon = new RemoteRicochetWeapon(object,getInitParam());
         this.weapons[param1] = _loc2_;
         return _loc2_;
      }
      
      public function onShot(param1:int, param2:int, param3:Vector3) : void
      {
         if(battleService.isBattleActive())
         {
            this.battleEventSupport.dispatchEvent(StateCorrectionEvent.MANDATORY_UPDATE);
            server.fireCommand(param1,param2,clientToServer(param3.x),clientToServer(param3.y),clientToServer(param3.z));
         }
      }
      
      public function onDummyShot(param1:int) : void
      {
         if(battleService.isBattleActive())
         {
            this.battleEventSupport.dispatchEvent(StateCorrectionEvent.MANDATORY_UPDATE);
            server.fireDummyCommand(param1);
         }
      }
      
      public function onTargetHit(param1:int, param2:Body, param3:Vector.<Vector3>) : void
      {
         var _loc4_:Tank = null;
         if(battleService.isBattleActive())
         {
            _loc4_ = param2.tank;
            server.hitTargetCommand(battleService.getPhysicsTime(),_loc4_.getUser(),param1,BattleUtils.getVector3d(param2.state.position),BattleUtils.getVector3dVector(param3));
         }
      }
      
      public function onStaticHit(param1:int, param2:Vector.<Vector3>) : void
      {
         if(battleService.isBattleActive())
         {
            server.hitStaticCommand(battleService.getPhysicsTime(),param1,BattleUtils.getVector3dVector(param2));
         }
      }
      
      private function onTankUnloaded(param1:TankUnloadedEvent) : void
      {
         delete this.weapons[param1.tank.getUser()];
      }
      
      public function addEnergy(param1:int) : void
      {
         this.localWeapon.addEnergy(param1);
      }
   }
}

