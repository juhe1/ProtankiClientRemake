package projects.tanks.client.entrance.model.entrance.externalentrance
{
   public class SocialNetworkEntranceParams
   {
      private var newname_8691__END:String;
      
      private var _enabled:Boolean;
      
      private var newname_8694__END:String;
      
      public function SocialNetworkEntranceParams(param1:String = null, param2:Boolean = false, param3:String = null)
      {
         super();
         this.newname_8691__END = param1;
         this._enabled = param2;
         this.newname_8694__END = param3;
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
         return this._enabled;
      }
      
      public function set enabled(param1:Boolean) : void
      {
         this._enabled = param1;
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
         var _loc1_:String = "SocialNetworkEntranceParams [";
         _loc1_ += "authorizationUrl = " + this.newname_8691__END + " ";
         _loc1_ += "enabled = " + this._enabled + " ";
         _loc1_ += "snId = " + this.newname_8694__END + " ";
         return _loc1_ + "]";
      }
   }
}

