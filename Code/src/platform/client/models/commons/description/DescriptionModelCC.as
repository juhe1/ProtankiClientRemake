package platform.client.models.commons.description
{
   public class DescriptionModelCC
   {
      
      private var _description:String;
      
      private var _name:String;
      
      public function DescriptionModelCC(param1:String = null, param2:String = null)
      {
         super();
         this._description = param1;
         this._name = param2;
      }
      
      public function get description() : String
      {
         return this._description;
      }
      
      public function set description(param1:String) : void
      {
         this._description = param1;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function set name(param1:String) : void
      {
         this._name = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "DescriptionModelCC [";
         _loc1_ += "description = " + this.description + " ";
         _loc1_ += "name = " + this.name + " ";
         return _loc1_ + "]";
      }
   }
}

