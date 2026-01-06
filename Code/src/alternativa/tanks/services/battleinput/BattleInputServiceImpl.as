package alternativa.tanks.services.battleinput
{
   import alternativa.tanks.utils.BitMask;
   import flash.events.EventDispatcher;
   
   public class BattleInputServiceImpl extends EventDispatcher implements BattleInputService
   {
      
      private const lockMask:BitMask = new BitMask();
      
      public function BattleInputServiceImpl()
      {
         super();
      }
      
      public function lock(param1:BattleInputLockType) : void
      {
         var _loc2_:Boolean = this.isChatLocked();
         var _loc3_:Boolean = this.isInputLocked();
         this.lockMask.setBits(param1.getMask());
         if(!_loc2_ && this.isChatLocked())
         {
            dispatchEvent(new BattleInputLockEvent(BattleInputLockEvent.CHAT_LOCKED));
         }
         if(!_loc3_ && this.isInputLocked())
         {
            dispatchEvent(new BattleInputLockEvent(BattleInputLockEvent.INPUT_LOCKED));
         }
      }
      
      public function unlock(param1:BattleInputLockType) : void
      {
         var _loc2_:Boolean = this.isChatLocked();
         var _loc3_:Boolean = this.isInputLocked();
         this.lockMask.clearBits(param1.getMask());
         if(_loc2_ && !this.isChatLocked())
         {
            dispatchEvent(new BattleInputLockEvent(BattleInputLockEvent.CHAT_UNLOCKED));
         }
         if(_loc3_ && !this.isInputLocked())
         {
            dispatchEvent(new BattleInputLockEvent(BattleInputLockEvent.INPUT_UNLOCKED));
         }
      }
      
      public function isInputLocked() : Boolean
      {
         return !this.lockMask.isEmpty();
      }
      
      public function isChatLocked() : Boolean
      {
         return this.lockMask.hasAnyBit(BattleInputLockType.MODAL_DIALOG.getMask());
      }
   }
}

