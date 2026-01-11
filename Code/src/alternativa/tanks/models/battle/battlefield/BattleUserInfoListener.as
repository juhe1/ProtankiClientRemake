package alternativa.tanks.models.battle.battlefield
{
   import alternativa.types.Long;
   
   public interface BattleUserInfoListener
   {
      
      function userInfoChanged(param1:String, param2:String, param3:int, param4:Boolean) : void;
      
      function userRankChanged(param1:String, param2:int) : void;
      
      function userSuspiciousnessChanged(param1:String, param2:Boolean) : void;
   }
}

