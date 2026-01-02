package projects.tanks.client.battleselect.model.battle.entrance
{
   import platform.client.fp10.core.model.IModel;
   import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
   
   public class BattleEntranceModelServer
   {
      private var model:IModel;
      
      public function BattleEntranceModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }
      
      public function fight(param1:BattleTeam) : void
      {
      }
      
      public function joinAsSpectator() : void
      {
      }
   }
}

