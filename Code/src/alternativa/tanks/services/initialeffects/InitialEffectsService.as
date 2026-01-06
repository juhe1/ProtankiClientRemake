package alternativa.tanks.services.initialeffects
{
   import alternativa.types.Long;
   import flash.utils.getTimer;
   
   public class InitialEffectsService implements IInitialEffectsService
   {
      
      private var initialEffects:Vector.<ClientBattleEffect>;
      
      public function InitialEffectsService()
      {
         super();
      }
      
      public function takeInitialEffects(param1:Long) : Vector.<ClientBattleEffect>
      {
         var _loc2_:Vector.<ClientBattleEffect> = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:ClientBattleEffect = null;
         if(this.initialEffects != null)
         {
            _loc3_ = int(this.initialEffects.length);
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               _loc5_ = this.initialEffects[_loc4_];
               if(_loc5_.userId == param1)
               {
                  if(_loc2_ == null)
                  {
                     _loc2_ = new Vector.<ClientBattleEffect>();
                  }
                  _loc2_.push(_loc5_);
                  this.initialEffects[_loc4_--] = this.initialEffects[--_loc3_];
                  this.initialEffects.length = _loc3_;
               }
               _loc4_++;
            }
            if(_loc3_ == 0)
            {
               this.initialEffects = null;
            }
         }
         return _loc2_;
      }
      
      public function addInitialEffect(param1:Long, param2:int, param3:int, param4:int) : void
      {
         if(this.initialEffects == null)
         {
            this.initialEffects = new Vector.<ClientBattleEffect>();
         }
         this.initialEffects.push(new ClientBattleEffect(getTimer(),param1,param2,param3,param4));
      }
      
      public function removeInitialEffect(param1:Long, param2:int) : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = this.indexOfInitialEffect(param1,param2);
         if(_loc3_ >= 0)
         {
            _loc4_ = int(this.initialEffects.length);
            this.initialEffects[_loc3_] = this.initialEffects[--_loc4_];
            this.initialEffects.length = _loc4_;
         }
      }
      
      private function indexOfInitialEffect(param1:Long, param2:int) : int
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:ClientBattleEffect = null;
         if(this.initialEffects != null)
         {
            _loc3_ = int(this.initialEffects.length);
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               _loc5_ = this.initialEffects[_loc4_];
               if(_loc5_.userId == param1 && _loc5_.effectId == param2)
               {
                  return _loc4_;
               }
               _loc4_++;
            }
         }
         return -1;
      }
   }
}

