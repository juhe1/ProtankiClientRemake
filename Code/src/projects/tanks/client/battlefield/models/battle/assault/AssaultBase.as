package projects.tanks.client.battlefield.models.battle.assault
{
   import projects.tanks.client.battlefield.types.Vector3d;
   
   public class AssaultBase
   {
      private var newname_1834__END:int;
      
      private var newname_6247__END:Vector3d;
      
      public function AssaultBase(param1:int = 0, param2:Vector3d = null)
      {
         super();
         this.newname_1834__END = param1;
         this.newname_6247__END = param2;
      }
      
      public function get id() : int
      {
         return this.newname_1834__END;
      }
      
      public function set id(param1:int) : void
      {
         this.newname_1834__END = param1;
      }
      
      public function get position() : Vector3d
      {
         return this.newname_6247__END;
      }
      
      public function set position(param1:Vector3d) : void
      {
         this.newname_6247__END = param1;
      }
      
      public function toString() : String
      {
         return "";
      }
   }
}

