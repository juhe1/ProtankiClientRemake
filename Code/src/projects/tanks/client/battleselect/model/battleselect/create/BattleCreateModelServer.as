package projects.tanks.client.battleselect.model.battleselect.create
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battleservice.BattleCreateParameters;

   public class BattleCreateModelServer
   {

      private var model:IModel;

      public function BattleCreateModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function checkBattleNameForForbiddenWords(param1:String) : void
      {
      }

      public function createBattle(param1:BattleCreateParameters) : void
      {
      }
   }
}
