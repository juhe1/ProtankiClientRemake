package projects.tanks.client.battlefield.models.user.resistance
{
   import projects.tanks.client.garage.models.item.properties.ItemProperty;
   
   public class TankResistance
   {
      
      private var _resistanceInPercent:int;
      
      private var _resistanceProperty:ItemProperty;
      
      public function TankResistance(param1:int = 0, param2:ItemProperty = null)
      {
         super();
         this._resistanceInPercent = param1;
         this._resistanceProperty = param2;
      }
      
      public function get resistanceInPercent() : int
      {
         return this._resistanceInPercent;
      }
      
      public function set resistanceInPercent(param1:int) : void
      {
         this._resistanceInPercent = param1;
      }
      
      public function get resistanceProperty() : ItemProperty
      {
         return this._resistanceProperty;
      }
      
      public function set resistanceProperty(param1:ItemProperty) : void
      {
         this._resistanceProperty = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "TankResistance [";
         _loc1_ += "resistanceInPercent = " + this.resistanceInPercent + " ";
         _loc1_ += "resistanceProperty = " + this.resistanceProperty + " ";
         return _loc1_ + "]";
      }
   }
}

