package projects.tanks.client.battlefield.models.user.suicide
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;

   public class SuicideModelServer
   {

      private var model:IModel;

      public function SuicideModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function suicideCommand() : void
      {
      }
   }
}
