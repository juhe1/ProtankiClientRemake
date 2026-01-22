package alternativa.tanks.model.info
{
   import alternativa.tanks.model.info.param.BattleParams;
   import alternativa.tanks.model.map.mapinfo.IMapInfo;
   import alternativa.tanks.service.battle.IBattleUserInfoService;
   import alternativa.tanks.view.battleinfo.BattleInfoBaseParams;
   import alternativa.types.Long;
   import flash.utils.getTimer;
   import platform.client.fp10.core.model.impl.Model;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battleselect.model.battle.BattleInfoCC;
   import projects.tanks.client.battleselect.model.battle.entrance.user.BattleInfoUser;
   import projects.tanks.client.battleselect.model.battle.param.BattleParamInfoCC;
   import projects.tanks.client.battleservice.BattleCreateParameters;
   import projects.tanks.clients.fp10.libraries.tanksservices.model.friends.FriendState;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.friend.IFriendInfoService;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.servername.ServerNumberToLocaleServerService;
   import projects.tanks.clients.fp10.libraries.tanksservices.utils.BattleInfoUtils;
   
   public class BattleParamsUtils
   {
      
      [Inject] // added
      public static var serverNameService:ServerNumberToLocaleServerService;
      
      [Inject] // added
      public static var battleUserInfoService:IBattleUserInfoService;
      
      [Inject] // added
      public static var friendsInfoService:IFriendInfoService;
      
      public function BattleParamsUtils()
      {
         super();
      }
      
      public static function setBattleInfoParams(param1:IGameObject, param2:BattleInfoBaseParams) : void
      {
         var _loc3_:BattleInfoCC = IBattleInfo(param1.adapt(IBattleInfo)).getConstructor();
         var _loc4_:BattleParamInfoCC = BattleParams(param1.adapt(BattleParams)).getConstructor();
         var _loc5_:BattleCreateParameters = _loc4_.params;
         param2.battle = Model.object;
         param2.createParams = _loc5_;
         param2.mapName = IMapInfo(_loc4_.map.adapt(IMapInfo)).getName();
         param2.customName = _loc4_.params.name;
         param2.matchmakingMark = IMapInfo(_loc4_.map.adapt(IMapInfo)).hasMatchmakingMark();
         param2.previewResource = IBattleInfo(param1.adapt(IBattleInfo)).getPreviewResource();
         param2.battleUrl = getBattleUrl(param2.battle.name);
         param2.endTime = getTimer() + _loc3_.timeLeftInSec * 1000;
         param2.roundStarted = _loc3_.roundStarted;
         param2.suspicionLevel = _loc3_.suspicionLevel;
      }
      
      private static function getBattleUrl(param1:String) : String
      {
         var _loc2_:String = "battle=" + BattleInfoUtils.getBattleIdUhex(param1);
         var _loc3_:String = BattleInfoUtils.getBattleBaseUrl();
         return (_loc3_ + "#/" + _loc2_).replace(/((.+)(\?.*)(#.*))/gi,"$2$4");
      }
      
      public static function registerUsers(param1:IGameObject, param2:Vector.<BattleInfoUser>, param3:BattleInfoBaseParams) : void
      {
         var _loc4_:BattleInfoUser = null;
         for each(_loc4_ in param2)
         {
            registerUser(_loc4_,param3,param1);
         }
      }

      public static function registerUsersSafe(param1:IGameObject, param2:Vector.<BattleInfoUser>, param3:BattleInfoBaseParams) : void
      {
         var _loc4_:BattleInfoUser = null;
         for each(_loc4_ in param2)
         {
            if(param3.userToInfo.get(_loc4_.user) == null)
            {
               continue;
            }
            registerUser(_loc4_,param3,param1);
         }
      }
      
      public static function registerUser(param1:BattleInfoUser, param2:BattleInfoBaseParams, param3:IGameObject) : void
      {
         var _loc4_:String = param1.user;
         param2.userToInfo.put(param1);
         battleUserInfoService.connect(_loc4_,param3);
         if(friendsInfoService.isFriendsInState(_loc4_,FriendState.ACCEPTED))
         {
            ++param2.friends;
         }
      }
      
      public static function unregisterUser(param1:String, param2:BattleInfoBaseParams) : void
      {
         param2.userToInfo.remove(param1);
         battleUserInfoService.disconnect(param1);
         if(friendsInfoService.isFriendsInState(param1,FriendState.ACCEPTED))
         {
            --param2.friends;
         }
      }
   }
}

