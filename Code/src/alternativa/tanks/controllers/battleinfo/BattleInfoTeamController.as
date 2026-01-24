package alternativa.tanks.controllers.battleinfo
{
   import alternativa.tanks.view.battleinfo.BattleInfoUserList;
   import alternativa.tanks.view.battleinfo.team.BattleInfoTeamParams;
   import alternativa.tanks.view.battleinfo.team.BattleInfoTeamView;
   import alternativa.types.Long;
   import fl.data.DataProvider;
   import flash.utils.Dictionary;
   import projects.tanks.client.battleselect.model.battle.entrance.user.BattleInfoUser;
   import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.user.IUserInfoService;
   
   public class BattleInfoTeamController extends AbstractBattleInfoController
   {
      
      [Inject] // added
      public static var userInfoService:IUserInfoService;
      
      private var userId2userList:Dictionary = new Dictionary();
      
      private var autoBalance:Boolean;
      
      public function BattleInfoTeamController()
      {
         super();
         view = new BattleInfoTeamView();
      }
      
      override protected function updateUserLists() : void
      {
         var _loc1_:BattleInfoTeamParams = BattleInfoTeamParams(initParams);
         this.updateUserList(maxPeopleCount,_loc1_.usersRed,this.teamView.redUserList);
         this.updateUserList(maxPeopleCount,_loc1_.usersBlue,this.teamView.blueUserList);
         this.autoBalance = initParams.createParams.autoBalance;
         this.updateAvailableEnterInBattle();
      }
      
      private function updateUserList(param1:int, param2:Vector.<BattleInfoUser>, param3:BattleInfoUserList) : void
      {
         param3.update(param1,param2);
         this.updateUserId2userList(param3);
      }
      
      override protected function updateAvailableEnterInBattle() : void
      {
         this.teamView.redFightButton.enabled = this.isFightButtonEnabledForTeam(this.teamView.redUserList,this.teamView.blueUserList) && this.isAvailableEnterInClanBattleForTeam(this.teamView.redUserList,this.teamView.blueUserList);
         this.teamView.blueFightButton.enabled = this.isFightButtonEnabledForTeam(this.teamView.blueUserList,this.teamView.redUserList) && this.isAvailableEnterInClanBattleForTeam(this.teamView.blueUserList,this.teamView.redUserList);
      }
      
      private function isFightButtonEnabledForTeam(param1:BattleInfoUserList, param2:BattleInfoUserList) : Boolean
      {
         return availableByRank && /*initParams.createParams.proBattle &&*/ param1.usersCount < maxPeopleCount && (!this.autoBalance || param1.usersCount <= param2.usersCount);
      }
      
      private function isAvailableEnterInClanBattleForTeam(param1:BattleInfoUserList, param2:BattleInfoUserList) : Boolean
      {
         return true;
         //var _loc6_:Long = null;
         //var _loc7_:Long = null;
         //if(!initParams.createParams.clanBattle)
         //{
         //   return true;
         //}
         //if(!clanUserInfoService.clanMember)
         //{
         //   return false;
         //}
         //var _loc3_:Boolean = true;
         //if(param1.usersCount == 0)
         //{
         //   _loc3_ = true;
         //}
         //var _loc4_:String = userInfoService.getCurrentUserId();
         //var _loc5_:Long = clanUserInfoService.userClanInfoByUserId(_loc4_).clanId;
         //if(param2.usersCount > 0)
         //{
         //   _loc6_ = param2.getTeamClanId();
         //   if(_loc6_ == _loc5_)
         //   {
         //      _loc3_ = false;
         //   }
         //}
         //if(param1.usersCount > 0)
         //{
         //   _loc7_ = param1.getTeamClanId();
         //   return _loc3_ && _loc7_ == _loc5_;
         //}
         //return _loc3_;
      }
      
      public function addUserToTeam(param1:BattleInfoUser, param2:BattleTeam) : void
      {
         var _loc3_:BattleInfoUserList = this.getTeamUserList(param2);
         _loc3_.addUser(param1);
         this.userId2userList[param1.user] = _loc3_;
         this.updateAvailableEnterInBattle();
      }
      
      override public function removeUser(param1:String) : void
      {
         this.userId2userList[param1].removeUser(param1);
         delete this.userId2userList[param1];
         this.updateAvailableEnterInBattle();
      }
      
      public function updateTeamScore(param1:BattleTeam, param2:int) : void
      {
         this.teamView.updateScore(param1,param2);
      }
      
      override public function updateUserScore(param1:String, param2:int) : void
      {
         this.userId2userList[param1].updateUserScore(param1,param2);
         this.teamView.invalidateUserList();
      }
      
      override public function updateUserSuspiciousState(param1:String, param2:Boolean) : void
      {
         this.userId2userList[param1].updateUserSuspiciousState(param1,param2);
         this.teamView.invalidateUserList();
      }
      
      override public function destroy() : void
      {
         super.destroy();
         this.userId2userList = null;
      }
      
      public function swapTeams() : void
      {
         var _loc1_:DataProvider = this.teamView.blueUserList.dataProvider;
         this.teamView.blueUserList.dataProvider = this.teamView.redUserList.dataProvider;
         this.teamView.redUserList.dataProvider = _loc1_;
         var _loc2_:int = this.teamView.blueUserList.usersCount;
         this.teamView.blueUserList.usersCount = this.teamView.redUserList.usersCount;
         this.teamView.redUserList.usersCount = _loc2_;
         this.updateUserId2userList(this.teamView.redUserList);
         this.updateUserId2userList(this.teamView.blueUserList);
         this.updateAvailableEnterInBattle();
      }
      
      private function updateUserId2userList(param1:BattleInfoUserList) : void
      {
         var _loc3_:Object = null;
         var _loc2_:int = 0;
         while(_loc2_ < param1.dataProvider.length)
         {
            _loc3_ = param1.dataProvider.getItemAt(_loc2_);
            if(_loc3_.id == null)
            {
               break;
            }
            this.userId2userList[_loc3_.id] = param1;
            _loc2_++;
         }
      }
      
      private function get teamView() : BattleInfoTeamView
      {
         return BattleInfoTeamView(view);
      }
      
      private function getTeamUserList(param1:BattleTeam) : BattleInfoUserList
      {
         return param1 == BattleTeam.RED ? this.teamView.redUserList : this.teamView.blueUserList;
      }
      
      override protected function updateControlPanel() : void
      {
         this.teamView.updateScore(BattleTeam.RED,BattleInfoTeamParams(initParams).scoreRed);
         this.teamView.updateScore(BattleTeam.BLUE,BattleInfoTeamParams(initParams).scoreBlue);
      }
   }
}

