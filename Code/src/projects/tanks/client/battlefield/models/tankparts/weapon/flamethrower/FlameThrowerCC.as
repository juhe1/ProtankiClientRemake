package projects.tanks.client.battlefield.models.tankparts.weapon.flamethrower
{
   public class FlameThrowerCC
   {
      
      private var _coneAngle:Number;
      
      private var _range:Number;
      
      public function FlameThrowerCC(param1:Number = 0, param2:Number = 0)
      {
         super();
         this._coneAngle = param1;
         this._range = param2;
      }
      
      public function get coneAngle() : Number
      {
         return this._coneAngle;
      }
      
      public function set coneAngle(param1:Number) : void
      {
         this._coneAngle = param1;
      }
      
      public function get range() : Number
      {
         return this._range;
      }
      
      public function set range(param1:Number) : void
      {
         this._range = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "FlameThrowerCC [";
         _loc1_ += "coneAngle = " + this.coneAngle + " ";
         _loc1_ += "range = " + this.range + " ";
         return _loc1_ + "]";
      }
   }
}

