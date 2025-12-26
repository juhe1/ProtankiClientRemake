package projects.tanks.client.tanksservices.model.notifier.battle
{
   import alternativa.types.Long;
   
   public interface IBattleNotifierModelBase
   {
      
      function leaveBattle(param1:String) : void;
      
      function leaveGroup(param1:String) : void;
      
      function setBattle(param1:Vector.<BattleNotifierData>) : void;
   }
}

