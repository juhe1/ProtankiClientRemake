package alternativa.tanks.view.battleinfo
{
   import alternativa.tanks.view.battleinfo.renderer.BattleInfoUserListRenderer;
   import alternativa.types.Long;
   import fl.controls.List;
   import fl.data.DataProvider;
   import forms.Styles;
   import projects.tanks.client.battleselect.model.battle.entrance.user.BattleInfoUser;
   import utils.ScrollStyleUtils;
   
   public class BattleInfoUserList extends List
   {
      
      public var usersCount:int;
      
      public function BattleInfoUserList()
      {
         super();
         rowHeight = 20;
         setStyle(Styles.CELL_RENDERER,BattleInfoUserListRenderer);
         focusEnabled = false;
         ScrollStyleUtils.setGreenStyle(this);
      }
      
      public function update(param1:int, param2:Vector.<BattleInfoUser>) : void
      {
         var _loc3_:BattleInfoUser = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         dataProvider = new DataProvider();
         this.usersCount = param2.length;
         for each(_loc3_ in param2)
         {
            this.addUserSlot(_loc3_);
         }
         this.sortUsersByScore();
         _loc4_ = param1 - this.usersCount;
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            this.addEmptySlot();
            _loc5_++;
         }
      }
      
      public function addUser(param1:BattleInfoUser) : void
      {
         this.addUserSlot(param1,this.getFreeIndex());
         ++this.usersCount;
      }
      
      public function removeUser(param1:String) : void
      {
         var _loc2_:int = this.getIndexById(param1);
         dataProvider.removeItemAt(_loc2_);
         this.addEmptySlot();
         --this.usersCount;
      }
      
      public function updateUserScore(param1:String, param2:int) : void
      {
         this.getUserById(param1).score = String(param2);
         this.sortUsersByScore();
      }
      
      public function updateUserSuspiciousState(param1:String, param2:Boolean) : void
      {
         this.getUserById(param1).suspicious = param2;
      }
      
      public function getTeamClanId() : Long
      {
         if(dataProvider.length > 0)
         {
            return dataProvider.getItemAt(0).clanId;
         }
         return null;
      }
      
      private function sortUsersByScore() : void
      {
         dataProvider.sortOn(["score"],[Array.DESCENDING | Array.NUMERIC]);
      }
      
      private function addUserSlot(param1:BattleInfoUser, param2:int = -1) : void
      {
         var _loc3_:Object = {};
         _loc3_.id = param1.user;
         _loc3_.suspicious = param1.suspicious;
         _loc3_.score = param1.score;
         _loc3_.clanId = param1.clanId;
         if(param2 > -1)
         {
            dataProvider.replaceItemAt(_loc3_,param2);
         }
         else
         {
            dataProvider.addItem(_loc3_);
         }
      }
      
      private function addEmptySlot() : void
      {
         var _loc1_:Object = {};
         _loc1_.score = -1;
         _loc1_.id = null;
         dataProvider.addItem(_loc1_);
      }
      
      private function getIndexById(param1:String) : int
      {
         var _loc2_:Object = null;
         var _loc3_:int = 0;
         while(_loc3_ < dataProvider.length)
         {
            _loc2_ = dataProvider.getItemAt(_loc3_);
            if(_loc2_.id == param1)
            {
               return _loc3_;
            }
            _loc3_++;
         }
         return -1;
      }
      
      private function getUserById(param1:String) : Object
      {
         var _loc2_:Object = null;
         var _loc3_:int = 0;
         while(_loc3_ < dataProvider.length)
         {
            _loc2_ = dataProvider.getItemAt(_loc3_);
            if(_loc2_.id == param1)
            {
               return _loc2_;
            }
            _loc3_++;
         }
         return null;
      }
      
      private function getFreeIndex() : uint
      {
         return this.usersCount;
      }
   }
}

