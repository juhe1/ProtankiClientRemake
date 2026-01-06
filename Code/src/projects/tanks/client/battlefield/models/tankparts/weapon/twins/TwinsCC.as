package projects.tanks.client.battlefield.models.tankparts.weapon.twins
{
   public class TwinsCC
   {
      
      private var _distance:Number;
      
      private var _shellRadius:Number;
      
      private var _speed:Number;
      
      public function TwinsCC(param1:Number = 0, param2:Number = 0, param3:Number = 0)
      {
         super();
         this._distance = param1;
         this._shellRadius = param2;
         this._speed = param3;
      }
      
      public function get distance() : Number
      {
         return this._distance;
      }
      
      public function set distance(param1:Number) : void
      {
         this._distance = param1;
      }
      
      public function get shellRadius() : Number
      {
         return this._shellRadius;
      }
      
      public function set shellRadius(param1:Number) : void
      {
         this._shellRadius = param1;
      }
      
      public function get speed() : Number
      {
         return this._speed;
      }
      
      public function set speed(param1:Number) : void
      {
         this._speed = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "TwinsCC [";
         _loc1_ += "distance = " + this.distance + " ";
         _loc1_ += "shellRadius = " + this.shellRadius + " ";
         _loc1_ += "speed = " + this.speed + " ";
         return _loc1_ + "]";
      }
   }
}

