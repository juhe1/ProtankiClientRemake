package projects.tanks.client.battleselect.model.matchmaking.queue
{
   public class MatchmakingMode
   {
      
      public static const TEAM_MODE:MatchmakingMode = new MatchmakingMode(0,"TEAM_MODE");
      
      public static const DM_ONLY:MatchmakingMode = new MatchmakingMode(1,"DM_ONLY");
      
      public static const TDM_ONLY:MatchmakingMode = new MatchmakingMode(2,"TDM_ONLY");
      
      public static const CTF_ONLY:MatchmakingMode = new MatchmakingMode(3,"CTF_ONLY");
      
      public static const CP_ONLY:MatchmakingMode = new MatchmakingMode(4,"CP_ONLY");
      
      public static const AS_ONLY:MatchmakingMode = new MatchmakingMode(5,"AS_ONLY");
      
      public static const RUGBY_ONLY:MatchmakingMode = new MatchmakingMode(6,"RUGBY_ONLY");
      
      public static const JGR_ONLY:MatchmakingMode = new MatchmakingMode(7,"JGR_ONLY");
      
      public static const HOLIDAY:MatchmakingMode = new MatchmakingMode(8,"HOLIDAY");
      
      private var _value:int;
      
      private var _name:String;
      
      public function MatchmakingMode(param1:int, param2:String)
      {
         super();
         this._value = param1;
         this._name = param2;
      }
      
      public static function get values() : Vector.<MatchmakingMode>
      {
         var _loc1_:Vector.<MatchmakingMode> = new Vector.<MatchmakingMode>();
         _loc1_.push(TEAM_MODE);
         _loc1_.push(DM_ONLY);
         _loc1_.push(TDM_ONLY);
         _loc1_.push(CTF_ONLY);
         _loc1_.push(CP_ONLY);
         _loc1_.push(AS_ONLY);
         _loc1_.push(RUGBY_ONLY);
         _loc1_.push(JGR_ONLY);
         _loc1_.push(HOLIDAY);
         return _loc1_;
      }
      
      public function toString() : String
      {
         return "MatchmakingMode [" + this._name + "]";
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

