package projects.tanks.client.panel.model.usercountry
{
   public class UserCountryCC
   {
      private var newname_5555__END:Vector.<CountryInfo>;
      
      private var newname_5556__END:String;
      
      private var newname_5557__END:Boolean;
      
      public function UserCountryCC(param1:Vector.<CountryInfo> = null, param2:String = null, param3:Boolean = false)
      {
         super();
         this.newname_5555__END = param1;
         this.newname_5556__END = param2;
         this.newname_5557__END = param3;
      }
      
      public function get countries() : Vector.<CountryInfo>
      {
         return this.newname_5555__END;
      }
      
      public function set countries(param1:Vector.<CountryInfo>) : void
      {
         this.newname_5555__END = param1;
      }
      
      public function get defaultCountryCode() : String
      {
         return this.newname_5556__END;
      }
      
      public function set defaultCountryCode(param1:String) : void
      {
         this.newname_5556__END = param1;
      }
      
      public function get locationCheckEnabled() : Boolean
      {
         return this.newname_5557__END;
      }
      
      public function set locationCheckEnabled(param1:Boolean) : void
      {
         this.newname_5557__END = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "UserCountryCC [";
         _loc1_ += "countries = " + this.newname_5555__END + " ";
         _loc1_ += "defaultCountryCode = " + this.newname_5556__END + " ";
         _loc1_ += "locationCheckEnabled = " + this.newname_5557__END + " ";
         return _loc1_ + "]";
      }
   }
}

