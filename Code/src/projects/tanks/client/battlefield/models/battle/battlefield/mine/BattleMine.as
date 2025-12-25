package projects.tanks.client.battlefield.models.battle.battlefield.mine
{
   import projects.tanks.client.battlefield.types.Vector3d;
   
   public class BattleMine
   {
      private var newname_5401__END:Boolean;
      
      private var newname_5402__END:String;
      
      private var newname_5403__END:String;
      
      private var newname_4906__END:Vector3d;
      
      public function BattleMine(param1:Boolean = false, param2:String = null, param3:String = null, param4:Vector3d = null)
      {
         super();
         this.newname_5401__END = param1;
         this.newname_5402__END = param2;
         this.newname_5403__END = param3;
         this.newname_4906__END = param4;
      }
      
      public function get activated() : Boolean
      {
         return this.newname_5401__END;
      }
      
      public function set activated(param1:Boolean) : void
      {
         this.newname_5401__END = param1;
      }
      
      public function get mineId() : String
      {
         return this.newname_5402__END;
      }
      
      public function set mineId(param1:String) : void
      {
         this.newname_5402__END = param1;
      }
      
      public function get ownerId() : String
      {
         return this.newname_5403__END;
      }
      
      public function set ownerId(param1:String) : void
      {
         this.newname_5403__END = param1;
      }
      
      public function get position() : Vector3d
      {
         return this.newname_4906__END;
      }
      
      public function set position(param1:Vector3d) : void
      {
         this.newname_4906__END = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "BattleMine [";
         _loc1_ += "activated = " + this.newname_5401__END + " ";
         _loc1_ += "mineId = " + this.newname_5402__END + " ";
         _loc1_ += "ownerId = " + this.newname_5403__END + " ";
         _loc1_ += "position = " + this.newname_4906__END + " ";
         return _loc1_ + "]";
      }
   }
}

