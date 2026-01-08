package projects.tanks.client.battlefield.models.battle.assault
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;

   public class AssaultModelServer
   {

      private var model:IModel;

      public function AssaultModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function dropFlagCommand() : void
      {
      }
   }
}
