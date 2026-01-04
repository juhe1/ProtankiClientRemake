package projects.tanks.client.commons.models.runtime
{
   import alternativa.types.Long;
   
   public class DataOwnerCC
   {
      
      private var _dataOwnerId:Long;
      
      public function DataOwnerCC(param1:Long = null)
      {
         super();
         this._dataOwnerId = param1;
      }
      
      public function get dataOwnerId() : Long
      {
         return this._dataOwnerId;
      }
      
      public function set dataOwnerId(param1:Long) : void
      {
         this._dataOwnerId = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "DataOwnerCC [";
         _loc1_ += "dataOwnerId = " + this.dataOwnerId + " ";
         return _loc1_ + "]";
      }
   }
}

