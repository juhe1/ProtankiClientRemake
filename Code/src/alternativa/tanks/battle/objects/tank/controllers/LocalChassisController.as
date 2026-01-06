package alternativa.tanks.battle.objects.tank.controllers
{
   import alternativa.osgi.service.command.CommandService;
   import alternativa.osgi.service.command.FormattedOutput;
   import alternativa.osgi.service.display.IDisplay;
   import alternativa.tanks.battle.events.BattleEventDispatcher;
   import alternativa.tanks.battle.events.BattleEventListener;
   import alternativa.tanks.battle.events.TargetingInputModeChangedEvent;
   import alternativa.tanks.battle.objects.tank.Tank;
   import alternativa.tanks.battle.objects.tank.tankchassis.TrackedChassis;
   import alternativa.tanks.service.settings.keybinding.GameActionEnum;
   import alternativa.tanks.service.settings.keybinding.KeysBindingService;
   import alternativa.tanks.utils.MathUtils;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   
   public class LocalChassisController extends ChassisController implements BattleEventListener
   {
      
      [Inject]
      public static var commandService:CommandService;
      
      [Inject]
      public static var display:IDisplay;
      
      [Inject]
      public static var battleEventDispatcher:BattleEventDispatcher;
      
      [Inject]
      public static var keyBindingService:KeysBindingService;
      
      private static const REVERSE_BACK_TURN_MASK:int = 1 << BIT_REVERSE_TURN;
      
      private var reverseBackTurnMask:int;
      
      private var cheatController:LocalCheatController;
      
      private var currentInputState:Boolean = true;
      
      public function LocalChassisController(param1:Tank, param2:ChassisControlListener)
      {
         super(param1,param2);
         display.stage.addEventListener(KeyboardEvent.KEY_DOWN,this.onKey);
         display.stage.addEventListener(KeyboardEvent.KEY_UP,this.onKey);
         display.stage.addEventListener(Event.DEACTIVATE,this.onClientWindowDeactivate);
         battleEventDispatcher.addBattleEventListener(TargetingInputModeChangedEvent,this);
      }
      
      public function handleBattleEvent(param1:Object) : void
      {
         var _loc2_:TargetingInputModeChangedEvent = null;
         if(param1 is TargetingInputModeChangedEvent)
         {
            _loc2_ = TargetingInputModeChangedEvent(param1);
            if(!this.currentInputState && _loc2_.enabled && !_loc2_.allowKeyboard)
            {
               setControlState(0,0);
            }
            this.currentInputState = _loc2_.enabled;
         }
      }
      
      private function onKey(param1:KeyboardEvent) : void
      {
         var _loc5_:int = 0;
         var _loc2_:GameActionEnum = keyBindingService.getBindingAction(param1.keyCode);
         if(!_loc2_)
         {
            return;
         }
         var _loc3_:int = controlState;
         var _loc4_:Boolean = param1.type == KeyboardEvent.KEY_DOWN;
         switch(_loc2_)
         {
            case GameActionEnum.CHASSIS_FORWARD_MOVEMENT:
               _loc3_ = MathUtils.changeBitValue(controlState,BIT_FORWARD,_loc4_);
               break;
            case GameActionEnum.CHASSIS_BACKWARD_MOVEMENT:
               _loc3_ = MathUtils.changeBitValue(controlState,BIT_BACK,_loc4_);
               break;
            case GameActionEnum.CHASSIS_LEFT_MOVEMENT:
               _loc3_ = MathUtils.changeBitValue(controlState,BIT_LEFT,_loc4_);
               break;
            case GameActionEnum.CHASSIS_RIGHT_MOVEMENT:
               _loc3_ = MathUtils.changeBitValue(controlState,BIT_RIGHT,_loc4_);
         }
         if(_loc3_ != controlState)
         {
            _loc5_ = _loc3_ | this.reverseBackTurnMask;
            setControlState(_loc5_,TrackedChassis.TURN_SPEED_COUNT);
         }
      }
      
      private function onClientWindowDeactivate(param1:Event) : void
      {
         setControlState(0,0);
      }
      
      override protected function onAppliedControlStateChanged(param1:int) : void
      {
         listener.onChassisControlChanged(param1,true);
      }
      
      public function setReversedBackTurn(param1:Boolean) : void
      {
         if(param1)
         {
            this.reverseBackTurnMask = REVERSE_BACK_TURN_MASK;
         }
         else
         {
            this.reverseBackTurnMask = 0;
            controlState &= ~REVERSE_BACK_TURN_MASK;
         }
      }
      
      [Obfuscation(rename="false")]
      override public function close() : void
      {
         super.close();
         display.stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.onKey);
         display.stage.removeEventListener(KeyboardEvent.KEY_UP,this.onKey);
         display.stage.removeEventListener(Event.DEACTIVATE,this.onClientWindowDeactivate);
         battleEventDispatcher.removeBattleEventListener(TargetingInputModeChangedEvent,this);
      }
      
      private function enableCheatControls(param1:FormattedOutput) : void
      {
      }
   }
}

