package projects.tanks.client.battlefield.models.tankparts.weapons.common
{
   import projects.tanks.client.battlefield.types.Vector3d;
   import alternativa.object.ClientObject;
   
   public class TargetPosition
   {
      private var newname_6244__END:Vector3d;
      
      private var newname_6245__END:Vector3d;
      
      private var newname_6246__END:Vector3d;
      
      private var newname_6247__END:Vector3d;
      
      private var newname_5312__END:ClientObject;
      
      private var newname_6248__END:Number;
      
      public function TargetPosition(param1:Vector3d = null, param2:Vector3d = null, param3:ClientObject = null, param4:Number = 0, param5:Vector3d = null, param6:Vector3d = null)
      {
         super();
         this.newname_6246__END = param1;
         this.newname_6247__END = param2;
         this.newname_5312__END = param3;
         this.newname_6248__END = param4;
         this.newname_6245__END = param5;
         this.newname_6244__END = param6;
      }
      
      public function get orientation() : Vector3d
      {
         return this.newname_6246__END;
      }
      
      public function set orientation(param1:Vector3d) : void
      {
         this.newname_6246__END = param1;
      }
      
      public function get position() : Vector3d
      {
         return this.newname_6247__END;
      }
      
      public function set position(param1:Vector3d) : void
      {
         this.newname_6247__END = param1;
      }
      
      public function get target() : ClientObject
      {
         return this.newname_5312__END;
      }
      
      public function set target(param1:ClientObject) : void
      {
         this.newname_5312__END = param1;
      }
      
      public function get turretAngle() : Number
      {
         return this.newname_6248__END;
      }
      
      public function set turretAngle(param1:Number) : void
      {
         this.newname_6248__END = param1;
      }
      
      public function get localHitPoint() : Vector3d
      {
         return this.newname_6245__END;
      }
      
      public function set localHitPoint(param1:Vector3d) : void
      {
         this.newname_6245__END = param1;
      }
      
      public function get shootDirection() : Vector3d
      {
         return this.newname_6244__END;
      }
      
      public function set shootDirection(param1:Vector3d) : void
      {
         this.newname_6244__END = param1;
      }
      
      public function toString() : String
      {
         return "";
      }
   }
}

