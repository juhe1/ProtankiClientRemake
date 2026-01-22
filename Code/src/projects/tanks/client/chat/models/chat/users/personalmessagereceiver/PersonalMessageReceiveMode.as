package projects.tanks.client.chat.models.chat.users.personalmessagereceiver
{
   public class PersonalMessageReceiveMode
   {
      
      public static const ALL:PersonalMessageReceiveMode = new PersonalMessageReceiveMode(0,"ALL");
      
      public static const FRIENDS_ONLY:PersonalMessageReceiveMode = new PersonalMessageReceiveMode(1,"FRIENDS_ONLY");
      
      public static const NONE:PersonalMessageReceiveMode = new PersonalMessageReceiveMode(2,"NONE");
      
      private var _value:int;
      
      private var _name:String;
      
      public function PersonalMessageReceiveMode(param1:int, param2:String)
      {
         super();
         this._value = param1;
         this._name = param2;
      }
      
      public static function get values() : Vector.<PersonalMessageReceiveMode>
      {
         var _loc1_:Vector.<PersonalMessageReceiveMode> = new Vector.<PersonalMessageReceiveMode>();
         _loc1_.push(ALL);
         _loc1_.push(FRIENDS_ONLY);
         _loc1_.push(NONE);
         return _loc1_;
      }
      
      public function toString() : String
      {
         return "PersonalMessageReceiveMode [" + this._name + "]";
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

