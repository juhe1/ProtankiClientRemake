package projects.tanks.client.battlefield.models.tankparts.weapons.common.shell
{
   import projects.tanks.client.battlefield.models.tankparts.weapons.common.TargetPosition;
   
   public class ShellHit
   {
      private var newname_7411__END:int;
      
      private var newname_7412__END:Vector.<ShellState>;
      
      private var newname_7413__END:Vector.<TargetPosition>;
      
      public function ShellHit(param1:int = 0, param2:Vector.<ShellState> = null, param3:Vector.<TargetPosition> = null)
      {
         super();
         this.newname_7411__END = param1;
         this.newname_7412__END = param2;
         this.newname_7413__END = param3;
      }
      
      public function get shotId() : int
      {
         return this.newname_7411__END;
      }
      
      public function set shotId(param1:int) : void
      {
         this.newname_7411__END = param1;
      }
      
      public function get state() : Vector.<ShellState>
      {
         return this.newname_7412__END;
      }
      
      public function set state(param1:Vector.<ShellState>) : void
      {
         this.newname_7412__END = param1;
      }
      
      public function get targets() : Vector.<TargetPosition>
      {
         return this.newname_7413__END;
      }
      
      public function set targets(param1:Vector.<TargetPosition>) : void
      {
         this.newname_7413__END = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "ShellHit [";
         _loc1_ += "shotId = " + this.shotId + " ";
         _loc1_ += "states = " + this.state + " ";
         _loc1_ += "targets = " + this.targets + " ";
         return _loc1_ + "]";
      }
   }
}

