package alternativa.tanks.models.statistics
{
   import alternativa.tanks.models.battle.gui.statistics.ShortUserInfo;
   import alternativa.types.Long;
   
   [ModelInterface]
   public interface IClientUserInfo
   {
      
      function getShortUserInfo(param1:String) : ShortUserInfo;
      
      function suspiciousnessChanged(param1:String, param2:Boolean) : void;
      
      function rankChanged(param1:String, param2:int) : void;
      
      function getUsersCount() : int;
      
      function isLoaded(param1:Long) : Boolean;
   }
}

