package alternativa.tanks.models.tank.support
{
   import alternativa.tanks.battle.objects.tank.TankControlLockBits;
   import alternativa.tanks.models.tank.ITankModel;
   import alternativa.tanks.services.battleinput.BattleInputLockEvent;
   import alternativa.tanks.services.battleinput.BattleInputService;
   import platform.client.fp10.core.type.AutoClosable;
   import platform.client.fp10.core.type.IGameObject;
   
   public class BattleInputLockSupport implements AutoClosable
   {
      
      [Inject] // added
      public static var battleInputService:BattleInputService;
      
      private var user:IGameObject;
      
      public function BattleInputLockSupport(param1:IGameObject)
      {
         super();
         this.user = param1;
         battleInputService.addEventListener(BattleInputLockEvent.INPUT_LOCKED,this.onInputLocked);
         battleInputService.addEventListener(BattleInputLockEvent.INPUT_UNLOCKED,this.onInputUnlocked);
      }
      
      private function onInputLocked(param1:BattleInputLockEvent) : void
      {
         var _loc2_:ITankModel = ITankModel(this.user.adapt(ITankModel));
         _loc2_.lockMovementControl(TankControlLockBits.INPUT);
         _loc2_.getWeaponController().lockWeapon(TankControlLockBits.INPUT,true);
      }
      
      private function onInputUnlocked(param1:BattleInputLockEvent) : void
      {
         var _loc2_:ITankModel = ITankModel(this.user.adapt(ITankModel));
         _loc2_.unlockMovementControl(TankControlLockBits.INPUT);
         _loc2_.getWeaponController().unlockWeapon(TankControlLockBits.INPUT);
      }
      
      [Obfuscation(rename="false")]
      public function close() : void
      {
         battleInputService.removeEventListener(BattleInputLockEvent.INPUT_LOCKED,this.onInputLocked);
         battleInputService.removeEventListener(BattleInputLockEvent.INPUT_UNLOCKED,this.onInputUnlocked);
         this.user = null;
      }
   }
}

