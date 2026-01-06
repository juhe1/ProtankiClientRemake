package projects.tanks.client.battlefield.models.tankparts.weapons.artillery.rotation
{
   public class ArtilleryElevatingBarrelCC
   {
      
      private var _angle:Number;
      
      private var _control:int;
      
      public function ArtilleryElevatingBarrelCC(param1:Number = 0, param2:int = 0)
      {
         super();
         this._angle = param1;
         this._control = param2;
      }
      
      public function get angle() : Number
      {
         return this._angle;
      }
      
      public function set angle(param1:Number) : void
      {
         this._angle = param1;
      }
      
      public function get control() : int
      {
         return this._control;
      }
      
      public function set control(param1:int) : void
      {
         this._control = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "ArtilleryElevatingBarrelCC [";
         _loc1_ += "angle = " + this.angle + " ";
         _loc1_ += "control = " + this.control + " ";
         return _loc1_ + "]";
      }
   }
}

