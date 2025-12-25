package projects.tanks.client.battlefield.models.tankparts.weapons.common.discrete
{
   import projects.tanks.client.battlefield.types.Vector3d;
   import alternativa.object.ClientObject;
   
   public class TargetHit
   {
      private var newname_6244__END:Vector3d;
      
      private var newname_6245__END:Vector3d;
      
      private var newname_10920__END:int;
      
      private var newname_5312__END:ClientObject;
      
      public function TargetHit(param1:Vector3d = null, param2:Vector3d = null, param3:int = 0, param4:ClientObject = null)
      {
         super();
         this.newname_6244__END = param1;
         this.newname_6245__END = param2;
         this.newname_10920__END = param3;
         this.newname_5312__END = param4;
      }
      
      public function get direction() : Vector3d
      {
         return this.newname_6244__END;
      }
      
      public function set direction(param1:Vector3d) : void
      {
         this.newname_6244__END = param1;
      }
      
      public function get localHitPoint() : Vector3d
      {
         return this.newname_6245__END;
      }
      
      public function set localHitPoint(param1:Vector3d) : void
      {
         this.newname_6245__END = param1;
      }
      
      public function get numberHits() : int
      {
         return this.newname_10920__END;
      }
      
      public function set numberHits(param1:int) : void
      {
         this.newname_10920__END = param1;
      }
      
      public function get target() : ClientObject
      {
         return this.newname_5312__END;
      }
      
      public function set target(param1:ClientObject) : void
      {
         this.newname_5312__END = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "TargetHit [";
         _loc1_ += "direction = " + this.direction + " ";
         _loc1_ += "localHitPoint = " + this.localHitPoint + " ";
         _loc1_ += "numberHits = " + this.numberHits + " ";
         _loc1_ += "target = " + this.target + " ";
         return _loc1_ + "]";
      }
   }
}

