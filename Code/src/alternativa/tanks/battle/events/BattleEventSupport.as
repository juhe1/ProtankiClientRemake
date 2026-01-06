package alternativa.tanks.battle.events
{
   import flash.utils.Dictionary;
   
   public class BattleEventSupport implements BattleEventListener
   {
      
      private var dispatcher:BattleEventDispatcher;
      
      private var listener:BattleEventListener;
      
      private var handlers:Dictionary = new Dictionary();
      
      public function BattleEventSupport(param1:BattleEventDispatcher, param2:BattleEventListener = null)
      {
         super();
         this.dispatcher = param1;
         if(param2 == null)
         {
            param2 = this;
         }
         this.listener = param2;
      }
      
      public function addEventHandler(param1:Class, param2:Function) : void
      {
         this.handlers[param1] = param2;
      }
      
      public function activateHandlers() : void
      {
         var _loc1_:* = undefined;
         for(_loc1_ in this.handlers)
         {
            this.dispatcher.addBattleEventListener(_loc1_,this.listener);
         }
      }
      
      public function deactivateHandlers() : void
      {
         var _loc1_:* = undefined;
         for(_loc1_ in this.handlers)
         {
            this.dispatcher.removeBattleEventListener(_loc1_,this.listener);
         }
      }
      
      public function handleBattleEvent(param1:Object) : void
      {
         var _loc2_:Function = this.handlers[param1.constructor];
         if(_loc2_ != null)
         {
            _loc2_(param1);
         }
      }
      
      public function dispatchEvent(param1:Object) : void
      {
         this.dispatcher.dispatchEvent(param1);
      }
   }
}

