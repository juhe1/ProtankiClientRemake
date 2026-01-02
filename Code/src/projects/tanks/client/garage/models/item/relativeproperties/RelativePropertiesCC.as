package projects.tanks.client.garage.models.item.relativeproperties
{
   public class RelativePropertiesCC
   {
      
      private var _properties:Vector.<RelativeProperty>;
      
      public function RelativePropertiesCC(param1:Vector.<RelativeProperty> = null)
      {
         super();
         this._properties = param1;
      }
      
      public function get properties() : Vector.<RelativeProperty>
      {
         return this._properties;
      }
      
      public function set properties(param1:Vector.<RelativeProperty>) : void
      {
         this._properties = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "RelativePropertiesCC [";
         _loc1_ += "properties = " + this.properties + " ";
         return _loc1_ + "]";
      }
   }
}

