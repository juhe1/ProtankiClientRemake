package alternativa.tanks.models.battle.gui.inventory.cooldown
{
   import alternativa.tanks.models.battle.gui.inventory.splash.ISplashController;
   import alternativa.tanks.models.battle.gui.inventory.splash.SplashColor;
   import alternativa.tanks.models.inventory.InventoryItemType;
   import flash.utils.getTimer;
   import utils.tweener.TweenLite;
   
   public class CooldownController
   {
      
      private var _view:CooldownIndicator;
      
      private var _finishCallback:Function;
      
      private var _finishFillCallback:Function;
      
      private var _startTime:int;
      
      private var _durationTime:int;
      
      private var _isActive:Boolean;
      
      private var _isFillEffect:Boolean;
      
      private var _fillTween:TweenLite;
      
      private var _addingTween:TweenLite;
      
      private var _isAddingEffect:Boolean;
      
      private var _cooldownProgressData:CooldownProgressData = new CooldownProgressData();
      
      private var _splashController:ISplashController;
      
      private var _effectProgress:Number = 1;
      
      private var _slotNumber:int;
      
      private var _fixProgressTime:* = 0;
      
      private var _fixProgress:* = 0;
      
      private var _lastProgress:* = 0;
      
      private var _lastTime:* = 0;
      
      public function CooldownController(param1:int, param2:CooldownIndicator, param3:ISplashController, param4:Function, param5:Function)
      {
         super();
         this._view = param2;
         this._slotNumber = param1;
         this._splashController = param3;
         this._finishCallback = param4;
         this._finishFillCallback = param5;
      }
      
      public function update(param1:int, param2:Number) : void
      {
         this._effectProgress = param2;
         if(!this._isActive)
         {
            return;
         }
         if(this._isFillEffect)
         {
            return;
         }
         if(this._isAddingEffect)
         {
            return;
         }
         if(param1 >= this._startTime)
         {
            this._cooldownProgressData.progress = this.calculateProgress(param1);
            this._lastTime = param1;
            this._lastProgress = this._cooldownProgressData.progress;
            if(this._cooldownProgressData.progress > 1)
            {
               this._cooldownProgressData.progress = 1;
               this.finish();
            }
         }
         this.setProgress(this._cooldownProgressData.progress,param2);
      }
      
      private function setProgress(param1:Number, param2:Number) : void
      {
         if(param1 < param2)
         {
            this._view.setProgress(param1,param2);
         }
         else
         {
            this._view.setProgress(0,0);
         }
      }
      
      public function finish() : void
      {
         this._isActive = false;
         this._startTime = -1;
         this._view.setProgress(0,0);
         this._finishCallback.apply();
         this._fixProgressTime = 0;
         this._fixProgress = 0;
      }
      
      private function calculateProgress(param1:int) : Number
      {
         if(this._fixProgressTime != 0)
         {
            return (param1 - this._fixProgressTime) * (1 - this._fixProgress) / this._durationTime + this._fixProgress;
         }
         return (param1 - this._startTime) / this._durationTime;
      }
      
      public function get isActive() : Boolean
      {
         return this._isActive;
      }
      
      public function isCooldownStarted() : Boolean
      {
         return this._cooldownProgressData.progress != 0;
      }
      
      public function destroy() : void
      {
         if(this._isActive)
         {
            this._isActive = false;
            this._isFillEffect = false;
            this._isAddingEffect = false;
            this._startTime = -1;
            this._view.setProgress(0,0);
            this._fixProgressTime = 0;
            this._fixProgress = 0;
            TweenLite.killTweensOf(this._cooldownProgressData);
         }
      }
      
      public function activate(param1:int, param2:int, param3:Boolean, param4:Boolean) : void
      {
         if(param2 <= 0)
         {
            return;
         }
         this._isActive = true;
         this._startTime = param1;
         this._durationTime = param2;
         this._fixProgressTime = 0;
         this._fixProgress = 0;
         this.activateFillMode(param3,param4);
      }
      
      private function activateFillMode(param1:Boolean, param2:Boolean) : void
      {
         if(this._isFillEffect)
         {
            return;
         }
         this._isFillEffect = true;
         if(!param1)
         {
            if(this.needActivateWithSplash() && !param2)
            {
               this._splashController.startFlash(SplashColor.getColor(this._slotNumber));
            }
            else
            {
               this._splashController.startFlash(SplashColor.COOLDOWN);
            }
         }
         this._cooldownProgressData.progress = 0;
         this._cooldownProgressData.fillProgress = 1;
         this._view.setProgress(this._cooldownProgressData.fillProgress,1);
         this._fillTween = TweenLite.to(this._cooldownProgressData,InventoryCooldownItem.FILL_EFFECT_TIME_IN_SEC,{
            "fillProgress":0,
            "onComplete":this.onCompleteFill
         });
      }
      
      private function needActivateWithSplash() : Boolean
      {
         return this._slotNumber == InventoryItemType.MINE || this._slotNumber == InventoryItemType.GOLD || this._slotNumber == InventoryItemType.ULTIMATE;
      }
      
      private function onCompleteFill() : void
      {
         this._cooldownProgressData.fillProgress = 0;
         this.setProgress(0,this._effectProgress);
         this._finishFillCallback.apply();
         this._isFillEffect = false;
      }
      
      public function changeTime(param1:int, param2:int, param3:Boolean, param4:Boolean) : void
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         if(this._isActive)
         {
            _loc5_ = this.getRemainingTime();
            _loc6_ = param2 - _loc5_;
            if(_loc6_ > InventoryCooldownItem.TOLERANCE_EFFECT_TIME)
            {
               if(this._isFillEffect || this._isAddingEffect)
               {
                  if(this._isFillEffect)
                  {
                     _loc7_ = param2 - (_loc5_ + InventoryCooldownItem.FILL_EFFECT_TIME_IN_SEC * 1000);
                  }
                  if(this._isAddingEffect)
                  {
                     _loc7_ = param2 - (_loc5_ + InventoryCooldownItem.ADDING_EFFECT_TIME_IN_SEC * 1000);
                  }
                  if(_loc7_ > InventoryCooldownItem.TOLERANCE_EFFECT_TIME)
                  {
                     this._durationTime += _loc7_;
                  }
               }
               else
               {
                  this.activateAddingEffect(param1,param2,param3,param4);
               }
            }
         }
         else
         {
            _loc8_ = param1 + InventoryCooldownItem.FILL_EFFECT_TIME_IN_SEC * 1000;
            _loc9_ = param2 - InventoryCooldownItem.FILL_EFFECT_TIME_IN_SEC * 1000;
            this.activate(_loc8_,_loc9_,param3,param4);
         }
      }
      
      public function activateInfinite() : void
      {
         this._isActive = true;
         this._startTime = 0;
         this._durationTime = int.MAX_VALUE;
         this.activateFillMode(true,false);
      }
      
      public function setCooldownDuration(param1:int) : *
      {
         this._fixProgressTime = this._lastTime;
         this._fixProgress = this._lastProgress;
         this._durationTime = param1;
         this._startTime = this._lastTime;
      }
      
      public function startCooldownNow(param1:int) : void
      {
         this.destroy();
         this.activate(param1,this._durationTime,false,false);
      }
      
      private function activateAddingEffect(param1:int, param2:int, param3:Boolean, param4:Boolean) : void
      {
         if(this._isAddingEffect)
         {
            this.changeTime(param1,param2,param3,param4);
            return;
         }
         var _loc5_:int = param2 - InventoryCooldownItem.ADDING_EFFECT_TIME_IN_SEC * 1000;
         if(_loc5_ > InventoryCooldownItem.TOLERANCE_EFFECT_TIME)
         {
            this._isAddingEffect = true;
            if(!param3)
            {
               this._splashController.startFlash(SplashColor.COOLDOWN);
            }
            this._startTime = param1 + InventoryCooldownItem.ADDING_EFFECT_TIME_IN_SEC * 1000;
            this._durationTime = _loc5_;
            this._cooldownProgressData.addingProgress = this._cooldownProgressData.progress;
            this._addingTween = TweenLite.to(this._cooldownProgressData,InventoryCooldownItem.ADDING_EFFECT_TIME_IN_SEC,{
               "addingProgress":0,
               "onComplete":this.onCompleteAdding
            });
         }
      }
      
      private function onCompleteAdding() : void
      {
         this._cooldownProgressData.addingProgress = 0;
         this.setProgress(0,this._effectProgress);
         this._isAddingEffect = false;
      }
      
      private function getRemainingTime() : int
      {
         if(this._durationTime == 0 || this._startTime == -1)
         {
            return 0;
         }
         return this._durationTime - (getTimer() - this._startTime);
      }
   }
}

