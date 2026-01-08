package projects.tanks.client.battlefield.models.continuebattle
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;

   public class ContinueBattleModelServer
   {

      private var model:IModel;

      public function ContinueBattleModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function continueBattle() : void
      {
      }
   }
}
