package alternativa.tanks.model.info.team
{
   import alternativa.tanks.controllers.BattleSelectVectorUtil;
   import alternativa.tanks.model.info.BattleInfoParams;
   import alternativa.tanks.model.info.BattleParamsUtils;
   import alternativa.tanks.model.info.ShowInfo;
   import alternativa.tanks.service.battle.IBattleUserInfoService;
   import alternativa.tanks.service.battleinfo.IBattleInfoFormService;
   import alternativa.tanks.service.battlelist.IBattleListFormService;
   import alternativa.tanks.view.battleinfo.BattleInfoBaseParams;
   import alternativa.tanks.view.battleinfo.team.BattleInfoTeamParams;
   import alternativa.types.Long;
   import platform.client.fp10.core.model.ObjectLoadListener;
   import projects.tanks.client.battleselect.model.battle.entrance.user.BattleInfoUser;
   import projects.tanks.client.battleselect.model.battle.team.ITeamBattleInfoModelBase;
   import projects.tanks.client.battleselect.model.battle.team.TeamBattleInfoModelBase;
   import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.friend.IFriendInfoService;
   
   [ModelInfo]
   public class BattleTeamInfoModel extends TeamBattleInfoModelBase implements ITeamBattleInfoModelBase, BattleTeamInfo, ShowInfo, ObjectLoadListener, BattleInfoParams
   {
      
      [Inject] // added
      public static var battleListFormService:IBattleListFormService;
      
      [Inject] // added
      public static var friendsInfoService:IFriendInfoService;
      
      [Inject] // added
      public static var battleUserInfoService:IBattleUserInfoService;
      
      [Inject] // added
      public static var battleInfoFormService:IBattleInfoFormService;
      
      public function BattleTeamInfoModel()
      {
         super();
      }
      
      public function objectLoaded() : void
      {
         var _loc1_:BattleInfoTeamParams = null;
         _loc1_ = new BattleInfoTeamParams();
         putData(BattleInfoTeamParams,_loc1_);
         BattleParamsUtils.setBattleInfoParams(object,_loc1_);
         _loc1_.usersBlue = getInitParam().usersBlue.concat();
         _loc1_.usersRed = getInitParam().usersRed.concat();
         BattleParamsUtils.registerUsers(object,_loc1_.usersBlue,_loc1_);
         BattleParamsUtils.registerUsers(object,_loc1_.usersRed,_loc1_);
         _loc1_.scoreBlue = getInitParam().scoreBlue;
         _loc1_.scoreRed = getInitParam().scoreRed;
         battleListFormService.battleItemRecord(this.data());
      }

      public function reloadCC() : void
      {
         var _loc1_:BattleInfoTeamParams = BattleInfoTeamParams(getData(BattleInfoTeamParams));
         BattleParamsUtils.setBattleInfoParams(object,_loc1_);
         _loc1_.usersBlue = getInitParam().usersBlue.concat();
         _loc1_.usersRed = getInitParam().usersRed.concat();
         BattleParamsUtils.registerUsersSafe(object,_loc1_.usersBlue,_loc1_);
         BattleParamsUtils.registerUsersSafe(object,_loc1_.usersRed,_loc1_);
         _loc1_.scoreBlue = getInitParam().scoreBlue;
         _loc1_.scoreRed = getInitParam().scoreRed;
      }
     
      
      public function updateTeamScore(param1:BattleTeam, param2:int) : void
      {
         if(param1 == BattleTeam.RED)
         {
            this.data().scoreRed = param2;
         }
         else
         {
            this.data().scoreBlue = param2;
         }
         battleInfoFormService.updateTeamScore(param1,param2);
      }
      
      public function swapTeams() : void
      {
         var _loc1_:BattleInfoTeamParams = this.data();
         var _loc2_:Vector.<BattleInfoUser> = _loc1_.usersBlue;
         var _loc3_:Vector.<BattleInfoUser> = _loc1_.usersRed;
         _loc1_.usersRed = _loc2_;
         _loc1_.usersBlue = _loc3_;
         _loc1_.scoreBlue = _loc1_.scoreRed = 0;
         battleListFormService.swapTeams(object.name);
         battleInfoFormService.swapTeams();
      }
      
      public function addUser(param1:BattleInfoUser, param2:BattleTeam) : void
      {
         if(this.userExists(param1.user))
         {
            return;
         }
         var _loc3_:BattleInfoTeamParams = this.data();
         var _loc4_:Vector.<BattleInfoUser> = param2 == BattleTeam.RED ? _loc3_.usersRed : _loc3_.usersBlue;
         _loc4_.push(param1);
         BattleParamsUtils.registerUser(param1,_loc3_,object);
         battleInfoFormService.addUser(param1,param2);
         this.updateUsersCount();
      }
      
      public function removeUser(param1:String) : void
      {
         if(!this.userExists(param1))
         {
            return;
         }
         BattleSelectVectorUtil.deleteElementInUsersVector(this.data().usersBlue,param1);
         BattleSelectVectorUtil.deleteElementInUsersVector(this.data().usersRed,param1);
         BattleParamsUtils.unregisterUser(param1,this.data());
         this.updateUsersCount();
         battleInfoFormService.removeUser(param1);
      }
      
      public function showInfo() : void
      {
         var _data:BattleInfoTeamParams = this.data();
         battleInfoFormService.showTeamForm(_data);
      }
      
      public function updateUserScore(param1:String, param2:int) : void
      {
         this.data().userToInfo.get(param1).score = param2;
         battleInfoFormService.updateUserScore(param1,param2);
      }
      
      public function getUsersCountBlue() : int
      {
         return this.data().usersBlue.length;
      }
      
      public function getUsersCountRed() : int
      {
         return this.data().usersRed.length;
      }
      
      private function data() : BattleInfoTeamParams
      {
         return BattleInfoTeamParams(getData(BattleInfoTeamParams));
      }
      
      public function getParams() : BattleInfoBaseParams
      {
         return this.data();
      }
      
      private function updateUsersCount() : void
      {
         battleListFormService.updateUsersCount(object.name);
      }

      private function userExists(param1:String) : Boolean
      {
         return this.data().userToInfo.get(param1) != null;
      }
   }
}

