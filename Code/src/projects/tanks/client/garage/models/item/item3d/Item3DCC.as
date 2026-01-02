package projects.tanks.client.garage.models.item.item3d
{
   public class Item3DCC
   {
      
      private var _mounted:Boolean;
      
      public function Item3DCC(param1:Boolean = false)
      {
         super();
         this._mounted = param1;
      }
      
      public function get mounted() : Boolean
      {
         return this._mounted;
      }
      
      public function set mounted(param1:Boolean) : void
      {
         this._mounted = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "Item3DCC [";
         _loc1_ += "mounted = " + this.mounted + " ";
         return _loc1_ + "]";
      }
   }
}

