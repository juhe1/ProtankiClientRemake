package projects.tanks.client.battlefield.models.user.tank.commands
{
   public class RotateTurretCommand
   {
      private var newname_8569__END:Number;
      
      private var newname_8567__END:int;
      
      public function RotateTurretCommand(param1:Number = 0, param2:int = 0)
      {
         super();
         this.newname_8569__END = param1;
         this.newname_8567__END = param2;
      }
      
      public function get angle() : Number
      {
         return this.newname_8569__END;
      }
      
      public function set angle(param1:Number) : void
      {
         this.newname_8569__END = param1;
      }
      
      public function get control() : int
      {
         return this.newname_8567__END;
      }
      
      public function set control(param1:int) : void
      {
         this.newname_8567__END = param1;
      }
      
      public function toString() : String
      {
         return "";
      }
   }
}

