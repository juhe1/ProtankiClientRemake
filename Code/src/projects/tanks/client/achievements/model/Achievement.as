package projects.tanks.client.achievements.model
{
   public class Achievement
   {
      public static const FIRST_RANK_UP:Achievement = new Achievement(0,"FIRST_RANK_UP");
      
      public static const FIRST_PURCHASE:Achievement = new Achievement(1,"FIRST_PURCHASE");
      
      public static const FIGHT_FIRST_BATTLE:Achievement = new Achievement(2,"FIGHT_FIRST_BATTLE");
      
      public static const FIRST_DONATE:Achievement = new Achievement(3,"FIRST_DONATE");
      
      public static const FIRST_REFERRAL:Achievement = new Achievement(4,"FIRST_REFERRAL");
      
      public static const SET_EMAIL:Achievement = new Achievement(5,"SET_EMAIL");
      
      private var _value:int;
      
      private var _name:String;
      
      public function Achievement(param1:int, param2:String)
      {
         super();
         this._value = param1;
         this._name = param2;
      }
      
      public static function get values() : Vector.<Achievement>
      {
         var _loc1_:Vector.<Achievement> = new Vector.<Achievement>();
         _loc1_.push(FIRST_RANK_UP);
         _loc1_.push(FIRST_PURCHASE);
         _loc1_.push(FIGHT_FIRST_BATTLE);
         _loc1_.push(FIRST_DONATE);
         _loc1_.push(FIRST_REFERRAL);
         _loc1_.push(SET_EMAIL);
         return _loc1_;
      }
      
      public function toString() : String
      {
         return "Achievement [" + this._name + "]";
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

