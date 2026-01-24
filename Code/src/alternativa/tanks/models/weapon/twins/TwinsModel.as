package alternativa.tanks.models.weapon.twins
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
   import projects.tanks.client.battlefield.models.tankparts.weapon.twins.ITwinsModelBase;
   import projects.tanks.client.battlefield.models.tankparts.weapon.twins.TwinsCC;
   import projects.tanks.client.battlefield.models.tankparts.weapon.twins.TwinsModelBase;
   import projects.tanks.client.battlefield.types.Vector3d;
   
   [ModelInfo]
   public class TwinsModel extends TwinsModelBase implements ITwinsModelBase, ObjectLoadListener, IWeaponModel, TwinsWeaponCallback, BattleEventListener
   {
      
      [Inject] // added
      public static var battleService:BattleService;
      
      [Inject] // added
      public static var battleEventDispatcher:BattleEventDispatcher;
      
      private var weapons:Dictionary = new Dictionary();
      
      private var battleEventSupport:BattleEventSupport;
      
      public function TwinsModel()
      {
         super();
         this.battleEventSupport = new BattleEventSupport(battleEventDispatcher,this);
         this.battleEventSupport.addEventHandler(TankUnloadedEvent,this.onTankUnloaded);
         this.battleEventSupport.activateHandlers();
      }
      
      [Obfuscation(rename="false")]
      public function objectLoaded() : void
      {
         var _loc1_:TwinsCC = getInitParam();
         _loc1_.distance = BattleUtils.toClientScale(_loc1_.distance);
         _loc1_.speed = BattleUtils.toClientScale(_loc1_.speed);
         _loc1_.shellRadius = BattleUtils.toClientScale(_loc1_.shellRadius);
      }
      
      [Obfuscation(rename="false")]
      public function fire(param1:IGameObject, param2:int, param3:int, param4:Vector3d) : void
      {
         var _loc5_:RemoteTwinsWeapon = null;
         if(battleService.isBattleActive())
         {
            _loc5_ = this.weapons[param1];
            if(_loc5_ != null)
            {
               _loc5_.fire(param2,param3,BattleUtils.getVector3(param4));
            }
         }
      }
      
      [Obfuscation(rename="false")]
      public function fireDummy(param1:IGameObject, param2:int) : void
      {
         var _loc3_:RemoteTwinsWeapon = null;
         if(battleService.isBattleActive())
         {
            _loc3_ = this.weapons[param1];
            if(_loc3_ != null)
            {
               _loc3_.fireDummy(param2);
            }
         }
      }
      
      public function handleBattleEvent(param1:Object) : void
      {
         this.battleEventSupport.handleBattleEvent(param1);
      }
      
      public function createLocalWeapon(param1:IGameObject) : Weapon
      {
         var _loc2_:Weapon = new TwinsWeapon(param1,object,getInitParam());
         this.weapons[param1] = _loc2_;
         return _loc2_;
      }
      
      public function createRemoteWeapon(param1:IGameObject) : Weapon
      {
         var _loc2_:Weapon = new RemoteTwinsWeapon(object,getInitParam());
         this.weapons[param1] = _loc2_;
         return _loc2_;
      }
      
      public function onShot(param1:int, param2:int, param3:int, param4:Vector3) : void
      {
         if(battleService.isBattleActive())
         {
            this.battleEventSupport.dispatchEvent(StateCorrectionEvent.MANDATORY_UPDATE);
            server.fireCommand(param1,param3,param2,BattleUtils.getVector3d(param4));
         }
      }
      
      public function onDummyShot(param1:int, param2:int) : void
      {
         if(battleService.isBattleActive())
         {
            this.battleEventSupport.dispatchEvent(StateCorrectionEvent.MANDATORY_UPDATE);
            server.fireDummyCommand(param1,param2);
         }
      }
      
      public function onTargetHit(param1:int, param2:Body, param3:Vector3) : void
      {
         var _loc4_:Tank = null;
         var _loc5_:IGameObject = null;
         var _loc6_:Vector3d = null;
         if(battleService.isBattleActive())
         {
            _loc4_ = param2.tank;
            _loc5_ = _loc4_.getUser();
            _loc6_ = BattleUtils.getVector3d(param2.state.position);
            server.hitTargetCommand(battleService.getPhysicsTime(),param1,_loc5_,_loc6_,BattleUtils.getVector3d(param3));
         }
      }
      
      private function onTankUnloaded(param1:TankUnloadedEvent) : void
      {
         delete this.weapons[param1.tank.getUser()];
      }
      
      public function onStaticHit(param1:int, param2:Vector3) : void
      {
         if(battleService.isBattleActive())
         {
            server.hitStaticCommand(battleService.getPhysicsTime(),param1,BattleUtils.getVector3d(param2));
         }
      }
   }
}

