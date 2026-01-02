package projects.tanks.client.garage.models.garage.temperature
{
   public class TemperatureCC
   {
      
      private var _temperatureAutoDecrement:Number;
      
      public function TemperatureCC(param1:Number = 0)
      {
         super();
         this._temperatureAutoDecrement = param1;
      }
      
      public function get temperatureAutoDecrement() : Number
      {
         return this._temperatureAutoDecrement;
      }
      
      public function set temperatureAutoDecrement(param1:Number) : void
      {
         this._temperatureAutoDecrement = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "TemperatureCC [";
         _loc1_ += "temperatureAutoDecrement = " + this.temperatureAutoDecrement + " ";
         return _loc1_ + "]";
      }
   }
}

