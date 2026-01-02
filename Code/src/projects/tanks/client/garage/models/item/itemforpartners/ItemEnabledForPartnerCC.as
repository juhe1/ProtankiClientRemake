package projects.tanks.client.garage.models.item.itemforpartners
{
   public class ItemEnabledForPartnerCC
   {
      
      private var _availableForNonPartnerUsers:Boolean;
      
      private var _partnerId:String;
      
      public function ItemEnabledForPartnerCC(param1:Boolean = false, param2:String = null)
      {
         super();
         this._availableForNonPartnerUsers = param1;
         this._partnerId = param2;
      }
      
      public function get availableForNonPartnerUsers() : Boolean
      {
         return this._availableForNonPartnerUsers;
      }
      
      public function set availableForNonPartnerUsers(param1:Boolean) : void
      {
         this._availableForNonPartnerUsers = param1;
      }
      
      public function get partnerId() : String
      {
         return this._partnerId;
      }
      
      public function set partnerId(param1:String) : void
      {
         this._partnerId = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "ItemEnabledForPartnerCC [";
         _loc1_ += "availableForNonPartnerUsers = " + this.availableForNonPartnerUsers + " ";
         _loc1_ += "partnerId = " + this.partnerId + " ";
         return _loc1_ + "]";
      }
   }
}

