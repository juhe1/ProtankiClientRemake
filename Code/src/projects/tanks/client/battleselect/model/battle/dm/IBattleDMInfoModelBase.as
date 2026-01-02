package projects.tanks.client.battleselect.model.battle.dm
{
   import alternativa.types.Long;
   import projects.tanks.client.battleselect.model.battle.entrance.user.BattleInfoUser;
   
   public interface IBattleDMInfoModelBase
   {
      
      function addUser(param1:BattleInfoUser) : void;
      
      function removeUser(param1:String) : void;
      
      function updateUserScore(param1:String, param2:int) : void;
   }
}

