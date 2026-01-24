package alternativa.tanks.models.tank
{
   import alternativa.tanks.battle.events.BattleEventDispatcher;
   import alternativa.tanks.battle.events.BattleEventListener;
   import alternativa.tanks.battle.events.MainLoopExecutionErrorEvent;
   import alternativa.tanks.battle.objects.tank.TankControlLockBits;
   import platform.client.fp10.core.type.AutoClosable;
   import platform.client.fp10.core.type.IGameObject;
   
   public class MainLoopExecutionErrorHandler implements AutoClosable, BattleEventListener
   {
      
      [Inject] // added
      public static var battleEventDispatcher:BattleEventDispatcher;
      
      private var localUser:IGameObject;
      
      public function MainLoopExecutionErrorHandler(param1:IGameObject)
      {
         super();
         this.localUser = param1;
         battleEventDispatcher.addBattleEventListener(MainLoopExecutionErrorEvent,this);
      }
      
      public function handleBattleEvent(param1:Object) : void
      {
         var _loc2_:ITankModel = ITankModel(this.localUser.adapt(ITankModel));
         _loc2_.disableStateCorrection();
         _loc2_.lockMovementControl(TankControlLockBits.ERROR);
         _loc2_.getWeaponController().lockWeapon(TankControlLockBits.ERROR,false);
      }
      
      [Obfuscation(rename="false")]
      public function close() : void
      {
         this.localUser = null;
         battleEventDispatcher.removeBattleEventListener(MainLoopExecutionErrorEvent,this);
      }
   }
}

