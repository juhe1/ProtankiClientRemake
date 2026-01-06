package alternativa.tanks.battle.events
{
   import flash.utils.Dictionary;
   
   public class BattleEventDispatcherImpl implements BattleEventDispatcher
   {
      
      private var numberProcessingEvents:int;
      
      private var eventListeners:Dictionary = new Dictionary();
      
      private var newListeners:Dictionary = new Dictionary();
      
      private var removedListeners:Dictionary = new Dictionary();
      
      private var dispatchedOnce:Dictionary = new Dictionary();
      
      public function BattleEventDispatcherImpl()
      {
         super();
      }
      
      private static function addListener(param1:Dictionary, param2:Class, param3:BattleEventListener) : void
      {
         var _loc4_:Vector.<BattleEventListener> = param1[param2];
         if(_loc4_ == null)
         {
            _loc4_ = new Vector.<BattleEventListener>();
            param1[param2] = _loc4_;
         }
         if(_loc4_.indexOf(param3) < 0)
         {
            _loc4_.push(param3);
         }
      }
      
      private static function removeListener(param1:Dictionary, param2:Class, param3:BattleEventListener) : void
      {
         var _loc5_:int = 0;
         var _loc4_:Vector.<BattleEventListener> = param1[param2];
         if(_loc4_ != null)
         {
            _loc5_ = int(_loc4_.indexOf(param3));
            if(_loc5_ >= 0)
            {
               if(_loc4_.length == 1)
               {
                  delete param1[param2];
               }
               else
               {
                  _loc4_.splice(_loc5_,1);
               }
            }
         }
      }
      
      public function addBattleEventListener(param1:Class, param2:BattleEventListener) : void
      {
         if(this.numberProcessingEvents > 0)
         {
            removeListener(this.removedListeners,param1,param2);
            addListener(this.newListeners,param1,param2);
         }
         else
         {
            addListener(this.eventListeners,param1,param2);
         }
      }
      
      public function removeBattleEventListener(param1:Class, param2:BattleEventListener) : void
      {
         if(this.numberProcessingEvents > 0)
         {
            removeListener(this.newListeners,param1,param2);
            addListener(this.removedListeners,param1,param2);
         }
         else
         {
            removeListener(this.eventListeners,param1,param2);
         }
      }
      
      public function dispatchEvent(param1:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         ++this.numberProcessingEvents;
         var _loc2_:Vector.<BattleEventListener> = this.eventListeners[param1.constructor];
         if(_loc2_ != null)
         {
            _loc4_ = int(_loc2_.length);
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               BattleEventListener(_loc2_[_loc5_]).handleBattleEvent(param1);
               _loc5_++;
            }
         }
         --this.numberProcessingEvents;
         var _loc3_:IBattleEvent = param1 as IBattleEvent;
         if(_loc3_ != null)
         {
            _loc3_.recycle();
         }
         this.processDeferredActions();
      }
      
      public function dispatchEventOnce(param1:Object) : void
      {
         if(!this.dispatchedOnce[param1.constructor])
         {
            this.dispatchedOnce[param1.constructor] = true;
            this.dispatchEvent(param1);
         }
      }
      
      public function clearDispatchedOnce() : void
      {
         this.dispatchedOnce = new Dictionary();
      }
      
      private function processDeferredActions() : void
      {
         var _loc1_:* = undefined;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Class = null;
         var _loc5_:Vector.<BattleEventListener> = null;
         if(this.numberProcessingEvents > 0)
         {
            return;
         }
         for(_loc1_ in this.removedListeners)
         {
            _loc4_ = _loc1_;
            _loc5_ = this.removedListeners[_loc1_];
            delete this.removedListeners[_loc1_];
            _loc3_ = int(_loc5_.length);
            _loc2_ = 0;
            while(_loc2_ < _loc3_)
            {
               removeListener(this.eventListeners,_loc4_,_loc5_[_loc2_]);
               _loc2_++;
            }
         }
         for(_loc1_ in this.newListeners)
         {
            _loc4_ = _loc1_;
            _loc5_ = this.newListeners[_loc1_];
            delete this.newListeners[_loc1_];
            _loc3_ = int(_loc5_.length);
            _loc2_ = 0;
            while(_loc2_ < _loc3_)
            {
               addListener(this.eventListeners,_loc4_,_loc5_[_loc2_]);
               _loc2_++;
            }
         }
      }
   }
}

