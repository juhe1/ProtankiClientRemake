package alternativa.tanks.model.info
{
   import alternativa.osgi.service.locale.ILocaleService;
   import alternativa.tanks.loader.ILoaderWindowService;
   import alternativa.tanks.model.info.param.BattleParams;
   import alternativa.tanks.model.item.BattleFriendsListener;
   import alternativa.tanks.model.map.mapinfo.IMapInfo;
   import alternativa.tanks.service.battle.IBattleUserInfoService;
   import alternativa.tanks.service.battleinfo.IBattleInfoFormService;
   import alternativa.tanks.service.battlelist.IBattleListFormService;
   import alternativa.tanks.tracker.ITrackerService;
   import alternativa.tanks.view.battleinfo.BattleInfoBaseParams;
   import alternativa.types.Long;
   import flash.utils.getTimer;
   import platform.client.fp10.core.model.ObjectUnloadListener;
   import platform.client.fp10.core.model.ObjectUnloadPostListener;
   import platform.client.fp10.core.resource.types.ImageResource;
   import projects.tanks.client.battleselect.model.battle.BattleInfoCC;
   import projects.tanks.client.battleselect.model.battle.BattleInfoModelBase;
   import projects.tanks.client.battleselect.model.battle.IBattleInfoModelBase;
   import projects.tanks.client.battleselect.model.battle.param.BattleParamInfoCC;
   import projects.tanks.client.battleservice.model.types.BattleSuspicionLevel;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.alertservices.IAlertService;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.logging.battlelist.UserBattleSelectActionsService;
   
   [ModelInfo]
   public class BattleInfoModel extends BattleInfoModelBase implements IBattleInfoModelBase, ObjectUnloadListener, ObjectUnloadPostListener, IBattleInfo, BattleFriendsListener
   {
      
      [Inject] // added
      public static var battleInfoFormService:IBattleInfoFormService;
      
      [Inject] // added
      public static var battleAlertService:IAlertService;
      
      [Inject] // added
      public static var localeService:ILocaleService;
      
      [Inject] // added
      public static var trackerService:ITrackerService;
      
      [Inject] // added
      public static var alertService:IAlertService;
      
      [Inject] // added
      public static var userBattleSelectActionsService:UserBattleSelectActionsService;
      
      [Inject] // added
      public static var loaderWindowService:ILoaderWindowService;
      
      [Inject] // added
      public static var battleListFormService:IBattleListFormService;
      
      [Inject] // added
      public static var battleUserInfoService:IBattleUserInfoService;
      
      public function BattleInfoModel()
      {
         super();
      }
      
      public function roundFinished() : void
      {
         this.data().roundStarted = false;
         this.data().endTime = 0;
         battleInfoFormService.roundFinish();
      }
      
      public function roundStarted(param1:int) : void
      {
         this.data().roundStarted = true;
         this.data().endTime = getTimer() + param1 * 1000;
         this.data().userToInfo.resetScore();
         battleInfoFormService.roundStart(param1);
      }
      
      public function updateSuspicion(param1:BattleSuspicionLevel) : void
      {
         battleListFormService.updateSuspicious(object.name,param1);
      }
      
      public function updateUserSuspiciousState(param1:String, param2:Boolean) : void
      {
         battleInfoFormService.updateUserSuspiciousState(param1,param2);
      }
      
      public function objectUnloaded() : void
      {
         if(battleInfoFormService.getSelectedBattle() == object)
         {
            battleInfoFormService.hideBattleForms();
         }
      }
      
      public function getConstructor() : BattleInfoCC
      {
         return getInitParam();
      }
      
      public function getPreviewResource() : ImageResource
      {
         var _loc1_:BattleParamInfoCC = BattleParams(object.adapt(BattleParams)).getConstructor();
         return IMapInfo(_loc1_.map.adapt(IMapInfo)).getPreviewResource();
      }
      
      public function objectUnloadedPost() : void
      {
         battleUserInfoService.deleteBattleItem(object);
         battleListFormService.removeBattleItem(object.name);
      }
      
      public function onAddFriend(param1:String) : void
      {
         ++this.data().friends;
         this.updateUsersCount();
      }
      
      public function onDeleteFriend(param1:String) : void
      {
         --this.data().friends;
         this.updateUsersCount();
      }
      
      private function data() : BattleInfoBaseParams
      {
         return BattleInfoParams(object.adapt(BattleInfoParams)).getParams();
      }
      
      private function updateUsersCount() : void
      {
         battleListFormService.updateUsersCount(object.name);
      }
      
      public function setBattleName(param1:String) : void
      {
         this.data().customName = param1;
         this.updateBattleName();
      }
      
      private function updateBattleName() : void
      {
         battleListFormService.updateBattleName(object.name);
         battleInfoFormService.updateBattleName();
      }
      
      public function resetBattleName() : void
      {
         this.data().customName = null;
         this.updateBattleName();
      }
   }
}

