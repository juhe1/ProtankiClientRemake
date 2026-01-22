package alternativa.tanks.view.battlelist
{
   import alternativa.tanks.controllers.battlelist.BattleListItemParams;
   import alternativa.tanks.controllers.battlelist.IBattleListViewControllerCallback;
   import alternativa.types.Long;
   import projects.tanks.client.battleservice.BattleMode;
   import projects.tanks.client.battleservice.model.types.BattleSuspicionLevel;
   
   public interface IBattleListView
   {
      
      function show(param1:BattleMode) : void;
      
      function hide() : void;
      
      function destroy() : void;
      
      function setCallBack(param1:IBattleListViewControllerCallback) : void;
      
      function resetSelectedItem() : void;
      
      function createItem(param1:BattleListItemParams, param2:Boolean) : void;
      
      function removeItem(param1:String) : void;
      
      function setSelect(param1:String) : void;
      
      function updateSuspicious(param1:String, param2:BattleSuspicionLevel) : void;
      
      function updateUsersCount(param1:String) : void;
      
      function updateBattleName(param1:String) : void;
      
      function swapTeams(param1:String) : void;
      
      function updateAccessibleItems() : void;
      
      function resize(param1:Boolean = true) : void;
      
      function sortBattleList() : void;
      
      function getItemIndex(param1:String) : int;
      
      function unPressFilter(param1:BattleMode) : void;
      
      function lockFilter(param1:BattleMode) : void;
      
      function unLockFilter(param1:BattleMode) : void;
      
      function setBattleButtonEnabled(param1:Boolean) : void;
      
      function setBattleCreationEnabled(param1:Boolean) : void;
   }
}

