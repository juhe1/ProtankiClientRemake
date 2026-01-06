package alternativa.tanks.battle.objects.tank.controllers
{
   import alternativa.tanks.battle.objects.tank.Tank;
   import alternativa.tanks.utils.BitMask;
   import alternativa.tanks.utils.MathUtils;
   import platform.client.fp10.core.type.AutoClosable;
   
   public class ChassisController implements AutoClosable
   {
      
      public static const BIT_FORWARD:int = 0;
      
      public static const BIT_BACK:int = 1;
      
      public static const BIT_LEFT:int = 2;
      
      public static const BIT_RIGHT:int = 3;
      
      public static const BIT_REVERSE_TURN:int = 4;
      
      protected var controlState:int;
      
      protected var turnSpeedNumber:int;
      
      protected var appliedControlState:int;
      
      private var tank:Tank;
      
      private var lockMask:BitMask = new BitMask();
      
      protected var listener:ChassisControlListener;
      
      public function ChassisController(param1:Tank, param2:ChassisControlListener)
      {
         super();
         this.tank = param1;
         this.listener = param2;
      }
      
      public function isEnabled() : Boolean
      {
         return this.lockMask.isEmpty();
      }
      
      public function lock(param1:int) : void
      {
         var _loc2_:Boolean = this.isEnabled();
         this.lockMask.setBits(param1);
         if(_loc2_ && !this.isEnabled())
         {
            this.applyControlState(0,0);
         }
      }
      
      public function unlock(param1:int) : void
      {
         var _loc2_:Boolean = this.isEnabled();
         this.lockMask.clearBits(param1);
         if(this.isEnabled() && !_loc2_)
         {
            this.applyControlState(this.controlState,this.turnSpeedNumber);
         }
      }
      
      public function getControlState() : int
      {
         return this.isEnabled() ? this.controlState : 0;
      }
      
      public function setControlState(param1:int, param2:int) : void
      {
         this.controlState = param1;
         this.turnSpeedNumber = param2;
         if(this.isEnabled())
         {
            this.applyControlState(param1,param2);
         }
      }
      
      private function applyControlState(param1:int, param2:int) : void
      {
         var _loc3_:int = this.appliedControlState;
         this.appliedControlState = param1;
         var _loc4_:int = MathUtils.getBitValue(param1,BIT_FORWARD) - MathUtils.getBitValue(param1,BIT_BACK);
         var _loc5_:Number = MathUtils.getBitValue(param1,BIT_LEFT) - MathUtils.getBitValue(param1,BIT_RIGHT);
         var _loc6_:Boolean = MathUtils.getBitValue(param1,BIT_REVERSE_TURN) == 1;
         this.tank.setMovementParams(_loc4_,_loc5_,param2,_loc6_);
         if(_loc3_ != this.appliedControlState)
         {
            this.onAppliedControlStateChanged(this.appliedControlState);
         }
      }
      
      protected function onAppliedControlStateChanged(param1:int) : void
      {
         this.listener.onChassisControlChanged(param1,false);
      }
      
      protected function getTank() : Tank
      {
         return this.tank;
      }
      
      [Obfuscation(rename="false")]
      public function close() : void
      {
         this.tank = null;
      }
   }
}

