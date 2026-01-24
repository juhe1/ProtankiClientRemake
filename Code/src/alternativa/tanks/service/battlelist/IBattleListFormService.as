package alternativa.tanks.service.battlelist
{
   import alternativa.tanks.view.battleinfo.BattleInfoBaseParams;
   import flash.events.IEventDispatcher;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battleservice.model.types.BattleSuspicionLevel;
   
   public interface IBattleListFormService extends IEventDispatcher
   {
      
      function createAndShow() : void;
      
      function hideAndDestroy() : void;
      
      function battleItemRecord(param1:BattleInfoBaseParams) : void;
      
      function removeBattleItem(param1:String) : void;
      
      function selectBattleItemFromServer(param1:IGameObject) : void;
      
      function updateSuspicious(param1:String, param2:BattleSuspicionLevel) : void;
      
      function updateUsersCount(param1:String) : void;
      
      function updateBattleName(param1:String) : void;
      
      function swapTeams(param1:String) : void;
      
      function battleItemsPacketJoinSuccess() : void;
      
      function checkBattleButton() : void;
   }
}

