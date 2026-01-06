package projects.tanks.client.battlefield.models.tankparts.weapon.freeze
{
   public class FreezeCC
   {
      
      private var _damageAreaConeAngle:Number;
      
      private var _damageAreaRange:Number;
      
      public function FreezeCC(param1:Number = 0, param2:Number = 0)
      {
         super();
         this._damageAreaConeAngle = param1;
         this._damageAreaRange = param2;
      }
      
      public function get damageAreaConeAngle() : Number
      {
         return this._damageAreaConeAngle;
      }
      
      public function set damageAreaConeAngle(param1:Number) : void
      {
         this._damageAreaConeAngle = param1;
      }
      
      public function get damageAreaRange() : Number
      {
         return this._damageAreaRange;
      }
      
      public function set damageAreaRange(param1:Number) : void
      {
         this._damageAreaRange = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "FreezeCC [";
         _loc1_ += "damageAreaConeAngle = " + this.damageAreaConeAngle + " ";
         _loc1_ += "damageAreaRange = " + this.damageAreaRange + " ";
         return _loc1_ + "]";
      }
   }
}

