package projects.tanks.client.battleselect.model.battle.entrance.user
{
   import alternativa.types.Long;
   
   public class BattleInfoUser
   {
      
      private var _clanId:Long;
      
      private var _score:int;
      
      private var _suspicious:Boolean;
      
      private var _user:String;
      
      public function BattleInfoUser(param1:Long = null, param2:int = 0, param3:Boolean = false, param4:String = null)
      {
         super();
         this._clanId = param1;
         this._score = param2;
         this._suspicious = param3;
         this._user = param4;
      }
      
      public function get clanId() : Long
      {
         return this._clanId;
      }
      
      public function set clanId(param1:Long) : void
      {
         this._clanId = param1;
      }
      
      public function get score() : int
      {
         return this._score;
      }
      
      public function set score(param1:int) : void
      {
         this._score = param1;
      }
      
      public function get suspicious() : Boolean
      {
         return this._suspicious;
      }
      
      public function set suspicious(param1:Boolean) : void
      {
         this._suspicious = param1;
      }
      
      public function get user() : String
      {
         return this._user;
      }
      
      public function set user(param1:String) : void
      {
         this._user = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "BattleInfoUser [";
         _loc1_ += "clanId = " + this.clanId + " ";
         _loc1_ += "score = " + this.score + " ";
         _loc1_ += "suspicious = " + this.suspicious + " ";
         _loc1_ += "user = " + this.user + " ";
         return _loc1_ + "]";
      }
   }
}

