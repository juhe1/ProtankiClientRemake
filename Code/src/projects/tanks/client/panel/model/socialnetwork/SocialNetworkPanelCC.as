package projects.tanks.client.panel.model.socialnetwork
{
   public class SocialNetworkPanelCC
   {
      private var newname_8686__END:Boolean;
      
      private var newname_8687__END:Vector.<SocialNetworkPanelParams>;
      
      public function SocialNetworkPanelCC(param1:Boolean = false, param2:Vector.<SocialNetworkPanelParams> = null)
      {
         super();
         this.newname_8686__END = param1;
         this.newname_8687__END = param2;
      }
      
      public function get passwordCreated() : Boolean
      {
         return this.newname_8686__END;
      }
      
      public function set passwordCreated(param1:Boolean) : void
      {
         this.newname_8686__END = param1;
      }
      
      public function get socialNetworkParams() : Vector.<SocialNetworkPanelParams>
      {
         return this.newname_8687__END;
      }
      
      public function set socialNetworkParams(param1:Vector.<SocialNetworkPanelParams>) : void
      {
         this.newname_8687__END = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "SocialNetworkPanelCC [";
         _loc1_ += "passwordCreated = " + this.newname_8686__END + " ";
         _loc1_ += "socialNetworkParams = " + this.newname_8687__END + " ";
         return _loc1_ + "]";
      }
   }
}

