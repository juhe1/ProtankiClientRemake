package alternativa.tanks.service.battle
{
   import alternativa.types.Long;
   import platform.client.fp10.core.type.IGameObject;
   
   public interface IBattleUserInfoService
   {
      
      function getBattle(param1:String) : IGameObject;
      
      function connect(param1:String, param2:IGameObject) : void;
      
      function disconnect(param1:String) : void;
      
      function userInBattle(param1:String) : Boolean;
      
      function deleteBattleItem(param1:IGameObject) : void;
   }
}

