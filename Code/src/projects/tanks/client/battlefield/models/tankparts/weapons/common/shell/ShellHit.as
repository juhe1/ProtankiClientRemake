package projects.tanks.client.battlefield.models.tankparts.weapons.common.shell
{
   import projects.tanks.client.battlefield.models.tankparts.weapons.common.TargetPosition;
   
   public class ShellHit
   {
      
      private var _shotId:int;
      
      private var _states:Vector.<ShellState>;
      
      private var _targets:Vector.<TargetPosition>;
      
      public function ShellHit(param1:int = 0, param2:Vector.<ShellState> = null, param3:Vector.<TargetPosition> = null)
      {
         super();
         this._shotId = param1;
         this._states = param2;
         this._targets = param3;
      }
      
      public function get shotId() : int
      {
         return this._shotId;
      }
      
      public function set shotId(param1:int) : void
      {
         this._shotId = param1;
      }
      
      public function get states() : Vector.<ShellState>
      {
         return this._states;
      }
      
      public function set states(param1:Vector.<ShellState>) : void
      {
         this._states = param1;
      }
      
      public function get targets() : Vector.<TargetPosition>
      {
         return this._targets;
      }
      
      public function set targets(param1:Vector.<TargetPosition>) : void
      {
         this._targets = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "ShellHit [";
         _loc1_ += "shotId = " + this.shotId + " ";
         _loc1_ += "states = " + this.states + " ";
         _loc1_ += "targets = " + this.targets + " ";
         return _loc1_ + "]";
      }
   }
}

