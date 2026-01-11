package projects.tanks.client.battlefield.models.tankparts.sfx.bcsh
{
   public class BCSHModelCC
   {
      
      private var _data:Vector.<BCSHStruct>;
      
      public function BCSHModelCC(param1:Vector.<BCSHStruct> = null)
      {
         super();
         this._data = param1;
      }
      
      public function get data() : Vector.<BCSHStruct>
      {
         return this._data;
      }
      
      public function set data(param1:Vector.<BCSHStruct>) : void
      {
         this._data = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "BCSHModelCC [";
         _loc1_ += "data = " + this.data + " ";
         return _loc1_ + "]";
      }
   }
}

