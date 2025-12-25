package projects.tanks.client.panel.model.referrals
{
   public class ReferrerPanelCC
   {
      private var newname_8148__END:String;
      
      private var newname_8149__END:String;
      
      public function ReferrerPanelCC(param1:String = null, param2:String = null)
      {
         super();
         this.newname_8148__END = param1;
         this.newname_8149__END = param2;
      }
      
      public function get hash() : String
      {
         return this.newname_8148__END;
      }
      
      public function set hash(param1:String) : void
      {
         this.newname_8148__END = param1;
      }
      
      public function get host() : String
      {
         return this.newname_8149__END;
      }
      
      public function set host(param1:String) : void
      {
         this.newname_8149__END = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "ReferrerPanelCC [";
         _loc1_ += "hash = " + this.newname_8148__END + " ";
         _loc1_ += "host = " + this.newname_8149__END + " ";
         return _loc1_ + "]";
      }
   }
}

