package projects.tanks.client.tanksservices.model.notifier.uid
{
   public class UidNotifierData
   {
      private var newname_1048__END:String;
      
      private var newname_3328__END:String;
      
      public function UidNotifierData(param1:String = null, param2:String = null)
      {
         super();
         this.newname_1048__END = param1;
         this.newname_3328__END = param2;
      }
      
      public function get uid() : String
      {
         return this.newname_1048__END;
      }
      
      public function set uid(param1:String) : void
      {
         this.newname_1048__END = param1;
      }
      
      public function get userId() : String
      {
         return this.newname_3328__END;
      }
      
      public function set userId(param1:String) : void
      {
         this.newname_3328__END = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "UidNotifierData [";
         _loc1_ += "Username = " + this.newname_1048__END + " ";
         _loc1_ += "userId = " + this.newname_3328__END + " ";
         return _loc1_ + "]";
      }
   }
}

