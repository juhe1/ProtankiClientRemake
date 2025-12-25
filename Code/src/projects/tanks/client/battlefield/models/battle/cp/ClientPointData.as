package projects.tanks.client.battlefield.models.battle.cp
{
   import projects.tanks.client.battlefield.types.Vector3d;
   
   public class ClientPointData
   {
      private var newname_1834__END:int;
      
      private var newname_4932__END:String;
      
      private var newname_6247__END:Vector3d;
      
      private var newname_3542__END:Number;
      
      private var newname_8154__END:Number;
      
      private var newname_1829__END:ControlPointState;
      
      private var newname_8155__END:Vector.<String>;
      
      public function ClientPointData(param1:int = 0, param2:String = null, param3:Vector3d = null, param4:Number = 0, param5:Number = 0, param6:ControlPointState = null, param7:Vector.<String> = null)
      {
         super();
         this.newname_1834__END = param1;
         this.newname_4932__END = param2;
         this.newname_6247__END = param3;
         this.newname_3542__END = param4;
         this.newname_8154__END = param5;
         this.newname_1829__END = param6;
         this.newname_8155__END = param7;
      }
      
      public function get id() : int
      {
         return this.newname_1834__END;
      }
      
      public function set id(param1:int) : void
      {
         this.newname_1834__END = param1;
      }
      
      public function get name() : String
      {
         return this.newname_4932__END;
      }
      
      public function set name(param1:String) : void
      {
         this.newname_4932__END = param1;
      }
      
      public function get position() : Vector3d
      {
         return this.newname_6247__END;
      }
      
      public function set position(param1:Vector3d) : void
      {
         this.newname_6247__END = param1;
      }
      
      public function get score() : Number
      {
         return this.newname_3542__END;
      }
      
      public function set score(param1:Number) : void
      {
         this.newname_3542__END = param1;
      }
      
      public function get scoreChangeRate() : Number
      {
         return this.newname_8154__END;
      }
      
      public function set scoreChangeRate(param1:Number) : void
      {
         this.newname_8154__END = param1;
      }
      
      public function get currentState() : ControlPointState
      {
         return this.newname_1829__END;
      }
      
      public function set currentState(param1:ControlPointState) : void
      {
         this.newname_1829__END = param1;
      }
      
      public function get tankIds() : Vector.<String>
      {
         return this.newname_8155__END;
      }
      
      public function set tankIds(param1:Vector.<String>) : void
      {
         this.newname_8155__END = param1;
      }
      
      public function toString() : String
      {
         return "";
      }
   }
}

