package projects.tanks.client.commons.models.captcha
{
   public class CaptchaLocation
   {
      
      public static const LOGIN_FORM:CaptchaLocation = new CaptchaLocation(0,"LOGIN_FORM");
      
      public static const REGISTER_FORM:CaptchaLocation = new CaptchaLocation(1,"REGISTER_FORM");
      
      public static const CLIENT_STARTUP:CaptchaLocation = new CaptchaLocation(2,"CLIENT_STARTUP");
      
      public static const RESTORE_PASSWORD_FORM:CaptchaLocation = new CaptchaLocation(3,"RESTORE_PASSWORD_FORM");
      
      public static const EMAIL_CHANGE_HASH:CaptchaLocation = new CaptchaLocation(4,"EMAIL_CHANGE_HASH");
      
      public static const ACCOUNT_SETTINGS_FORM:CaptchaLocation = new CaptchaLocation(5,"ACCOUNT_SETTINGS_FORM");
      
      private var _value:int;
      
      private var _name:String;
      
      public function CaptchaLocation(param1:int, param2:String)
      {
         super();
         this._value = param1;
         this._name = param2;
      }
      
      public static function get values() : Vector.<CaptchaLocation>
      {
         var _loc1_:Vector.<CaptchaLocation> = new Vector.<CaptchaLocation>();
         _loc1_.push(LOGIN_FORM);
         _loc1_.push(REGISTER_FORM);
         _loc1_.push(CLIENT_STARTUP);
         _loc1_.push(RESTORE_PASSWORD_FORM);
         _loc1_.push(EMAIL_CHANGE_HASH);
         _loc1_.push(ACCOUNT_SETTINGS_FORM);
         return _loc1_;
      }
      
      public function toString() : String
      {
         return "CaptchaLocation [" + this._name + "]";
      }
      
      public function get value() : int
      {
         return this._value;
      }
      
      public function get name() : String
      {
         return this._name;
      }
   }
}

