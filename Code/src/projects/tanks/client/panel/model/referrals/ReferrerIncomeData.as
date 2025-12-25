package projects.tanks.client.panel.model.referrals
{
   public class ReferrerIncomeData
   {
      private var newname_8147__END:int;
      
      private var newname_3287__END:String;
      
      public function ReferrerIncomeData(param1:int = 0, param2:String = null)
      {
         super();
         this.newname_8147__END = param1;
         this.newname_3287__END = param2;
      }
      
      public function get income() : int
      {
         return this.newname_8147__END;
      }
      
      public function set income(param1:int) : void
      {
         this.newname_8147__END = param1;
      }
      
      public function get user() : String
      {
         return this.newname_3287__END;
      }
      
      public function set user(param1:String) : void
      {
         this.newname_3287__END = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "ReferrerIncomeData [";
         _loc1_ += "income = " + this.newname_8147__END + " ";
         _loc1_ += "user = " + this.newname_3287__END + " ";
         return _loc1_ + "]";
      }
   }
}

