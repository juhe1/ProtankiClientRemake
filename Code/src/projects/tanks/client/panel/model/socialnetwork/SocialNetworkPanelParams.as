package projects.tanks.client.panel.model.socialnetwork
{
   public class SocialNetworkPanelParams
   {
      private var newname_8691__END:String;
      
      private var newname_8692__END:Boolean;
      
      private var newname_8693__END:Boolean;
      
      private var newname_8694__END:String;
      
      public function SocialNetworkPanelParams(param1:String = null, param2:Boolean = false, param3:Boolean = false, param4:String = null)
      {
         super();
         this.newname_8691__END = param1;
         this.newname_8692__END = param2;
         this.newname_8693__END = param3;
         this.newname_8694__END = param4;
      }
      
      public function get authorizationUrl() : String
      {
         return this.newname_8691__END;
      }
      
      public function set authorizationUrl(param1:String) : void
      {
         this.newname_8691__END = param1;
      }
      
      public function get enabled() : Boolean
      {
         return this.newname_8692__END;
      }
      
      public function set enabled(param1:Boolean) : void
      {
         this.newname_8692__END = param1;
      }
      
      public function get linkExists() : Boolean
      {
         return this.newname_8693__END;
      }
      
      public function set linkExists(param1:Boolean) : void
      {
         this.newname_8693__END = param1;
      }
      
      public function get snId() : String
      {
         return this.newname_8694__END;
      }
      
      public function set snId(param1:String) : void
      {
         this.newname_8694__END = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "SocialNetworkPanelParams [";
         _loc1_ += "authorizationUrl = " + this.newname_8691__END + " ";
         _loc1_ += "enabled = " + this.newname_8692__END + " ";
         _loc1_ += "linkExists = " + this.newname_8693__END + " ";
         _loc1_ += "snId = " + this.newname_8694__END + " ";
         return _loc1_ + "]";
      }
   }
}

