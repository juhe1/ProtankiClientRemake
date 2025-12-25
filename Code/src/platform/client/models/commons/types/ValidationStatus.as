package platform.client.models.commons.types
{
   public class ValidationStatus
   {
      public static const TOO_SHORT:ValidationStatus = new ValidationStatus(0,"TOO_SHORT");
      
      public static const TOO_LONG:ValidationStatus = new ValidationStatus(1,"TOO_LONG");
      
      public static const NOT_UNIQUE:ValidationStatus = new ValidationStatus(2,"NOT_UNIQUE");
      
      public static const NOT_MATCH_PATTERN:ValidationStatus = new ValidationStatus(3,"NOT_MATCH_PATTERN");
      
      public static const FORBIDDEN:ValidationStatus = new ValidationStatus(4,"FORBIDDEN");
      
      public static const CORRECT:ValidationStatus = new ValidationStatus(5,"CORRECT");
      
      private var _value:int;
      
      private var _name:String;
      
      public function ValidationStatus(param1:int, param2:String)
      {
         super();
         this._value = param1;
         this._name = param2;
      }
      
      public static function get values() : Vector.<ValidationStatus>
      {
         var _loc1_:Vector.<ValidationStatus> = new Vector.<ValidationStatus>();
         _loc1_.push(TOO_SHORT);
         _loc1_.push(TOO_LONG);
         _loc1_.push(NOT_UNIQUE);
         _loc1_.push(NOT_MATCH_PATTERN);
         _loc1_.push(FORBIDDEN);
         _loc1_.push(CORRECT);
         return _loc1_;
      }
      
      public function toString() : String
      {
         return "ValidationStatus [" + this._name + "]";
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

