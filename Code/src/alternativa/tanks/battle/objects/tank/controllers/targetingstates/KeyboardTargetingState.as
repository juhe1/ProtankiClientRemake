package alternativa.tanks.battle.objects.tank.controllers.targetingstates
{
   import alternativa.tanks.battle.objects.tank.controllers.TargetingState;
   import alternativa.tanks.battle.objects.tank.controllers.TurretControlActionMap;
   import alternativa.tanks.battle.objects.tank.controllers.TurretController;
   import alternativa.tanks.service.settings.keybinding.GameActionEnum;
   import alternativa.tanks.service.settings.keybinding.KeysBindingService;
   import alternativa.tanks.services.targeting.TargetingInputListener;
   import alternativa.tanks.services.targeting.TargetingInputManager;
   import alternativa.tanks.services.targeting.TargetingModeService;
   
   public class KeyboardTargetingState implements TargetingState, TargetingInputListener
   {
      
      [Inject]
      public static var targetingModeService:TargetingModeService;
      
      [Inject]
      public static var inputManager:TargetingInputManager;
      
      [Inject]
      public static var keysBindingService:KeysBindingService;
      
      protected var turretController:TurretController;
      
      protected var actionMap:TurretControlActionMap;
      
      protected var oldKeyMap:TurretControlActionMap;
      
      public function KeyboardTargetingState(param1:TurretController)
      {
         super();
         this.turretController = param1;
         this.setKeyMap(TurretControlActionMap.DEFAULT_ACTION_MAP);
         targetingModeService.setKeyMap(TurretControlActionMap.DEFAULT_ACTION_MAP);
      }
      
      public function keyboardButton(param1:uint, param2:Boolean) : Boolean
      {
         var _loc3_:GameActionEnum = keysBindingService.getBindingAction(param1);
         if(!_loc3_)
         {
            return true;
         }
         this.turretController.saveKeyState(_loc3_.value,param2);
         this.applyAction(_loc3_,param2);
         return true;
      }
      
      protected function applyAction(param1:GameActionEnum, param2:Boolean) : void
      {
         switch(param1)
         {
            case this.actionMap.actionLeft:
               this.turretController.rotateLeft(param2);
               break;
            case this.actionMap.actionRight:
               this.turretController.rotateRight(param2);
               break;
            case this.actionMap.actionUp:
               this.turretController.rotateUp(param2);
               break;
            case this.actionMap.actionDown:
               this.turretController.rotateDown(param2);
               break;
            case this.actionMap.actionCenter:
               this.turretController.center(param2);
         }
      }
      
      public function enter() : void
      {
         inputManager.addListener(this);
         if(this.oldKeyMap == null)
         {
            this.oldKeyMap = targetingModeService.getKeyMap();
            targetingModeService.setKeyMap(this.actionMap);
         }
         this.restoreKeyStates();
      }
      
      private function restoreKeyStates() : void
      {
         this.restoreActionState(this.actionMap.actionCenter);
         this.restoreActionState(this.actionMap.actionDown);
         this.restoreActionState(this.actionMap.actionLeft);
         this.restoreActionState(this.actionMap.actionRight);
         this.restoreActionState(this.actionMap.actionUp);
      }
      
      private function restoreActionState(param1:GameActionEnum) : void
      {
         if(!param1)
         {
            return;
         }
         if(this.turretController.loadKeyState(param1.value))
         {
            this.applyAction(param1,true);
         }
      }
      
      public function exit() : void
      {
         inputManager.removeListener(this);
         if(this.oldKeyMap != null)
         {
            targetingModeService.setKeyMap(this.oldKeyMap);
            this.oldKeyMap = null;
         }
      }
      
      protected function setKeyMap(param1:TurretControlActionMap) : void
      {
         this.actionMap = param1;
      }
      
      public function tick(param1:Number) : void
      {
      }
      
      public function mouseAbsoluteMovement(param1:Number, param2:Number) : void
      {
      }
      
      public function mouseRelativeMovement(param1:Number, param2:Number) : void
      {
      }
      
      public function mouseLeftButton(param1:Boolean, param2:Boolean) : Boolean
      {
         return true;
      }
      
      public function mouseWheel(param1:int) : void
      {
      }
      
      public function mouseRightButton(param1:Boolean, param2:Boolean) : Boolean
      {
         return true;
      }
      
      public function mouseLocked(param1:Boolean) : void
      {
      }
   }
}

