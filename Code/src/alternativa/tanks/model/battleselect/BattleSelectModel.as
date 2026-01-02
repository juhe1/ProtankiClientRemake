package alternativa.tanks.model.battleselect
{
   import alternativa.tanks.controllers.battlelist.BattleByURLNotFoundEvent;
   import alternativa.tanks.model.info.ShowInfo;
   import alternativa.tanks.service.battle.BattleFriendNotifier;
   import alternativa.tanks.service.battleinfo.IBattleInfoFormService;
   import alternativa.tanks.service.battlelist.BattleListFormServiceEvent;
   import alternativa.tanks.service.battlelist.IBattleListFormService;
   import alternativa.tanks.tracker.ITrackerService;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import platform.client.fp10.core.model.ObjectLoadPostListener;
   import platform.client.fp10.core.model.ObjectUnloadListener;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battleselect.model.battleselect.BattleSelectModelBase;
   import projects.tanks.client.battleselect.model.battleselect.IBattleSelectModelBase;
   import alternativa.tanks.model.info.param.BattleParams;
   
   [ModelInfo]
   public class BattleSelectModel extends BattleSelectModelBase implements IBattleSelectModelBase, ObjectLoadPostListener, ObjectUnloadListener
   {
      
      [Inject] // added
      public static var battleListFormService:IBattleListFormService;
      
      [Inject] // added
      public static var battleInfoFormService:IBattleInfoFormService;
      
      [Inject] // added
      public static var trackerService:ITrackerService;
      
      private var battleFriendNotifier:BattleFriendNotifier;
      
      private var selectTimeoutId:int = -1;
      
      public function BattleSelectModel()
      {
         super();
      }
      
      public function select(param1:IGameObject) : void
      {
         battleListFormService.selectBattleItemFromServer(param1);
         //ShowInfo(param1.adapt(ShowInfo)).showInfo();
         this.clearSelectTimeout();
      }
      
      public function objectLoadedPost() : void
      {
         this.battleFriendNotifier = new BattleFriendNotifier();
         battleListFormService.createAndShow();
         battleListFormService.addEventListener(BattleListFormServiceEvent.BATTLE_SELECTED,getFunctionWrapper(this.onBattleSelected));
         battleListFormService.addEventListener(BattleByURLNotFoundEvent.BATTLE_BY_URL_NOT_FOUND,getFunctionWrapper(this.onBattleByURLNotFound));
         trackerService.trackEvent("battleList","init","");
      }
      
      public function objectUnloaded() : void
      {
         this.battleFriendNotifier.destroy();
         this.battleFriendNotifier = null;
         battleInfoFormService.destroy();
         battleListFormService.removeEventListener(BattleListFormServiceEvent.BATTLE_SELECTED,getFunctionWrapper(this.onBattleSelected));
         battleListFormService.removeEventListener(BattleByURLNotFoundEvent.BATTLE_BY_URL_NOT_FOUND,getFunctionWrapper(this.onBattleByURLNotFound));
         battleListFormService.hideAndDestroy();
         this.clearSelectTimeout();
      }
      
      private function onBattleSelected(param1:BattleListFormServiceEvent) : void
      {
         var event:BattleListFormServiceEvent = param1;
         this.clearSelectTimeout();
         var battleId:String = BattleParams(param1.selectedItem.adapt(BattleParams)).getConstructor().params.battleId;
         server.onSelect(battleId + " ");
      }
      
      private function onBattleByURLNotFound(param1:BattleByURLNotFoundEvent) : void
      {
         server.search(param1.battleId);
      }
      
      public function battleItemsPacketJoinSuccess() : void
      {
         battleListFormService.battleItemsPacketJoinSuccess();
      }
      
      private function clearSelectTimeout() : void
      {
         if(this.selectTimeoutId != -1)
         {
            clearTimeout(this.selectTimeoutId);
         }
         this.selectTimeoutId = -1;
      }
   }
}

