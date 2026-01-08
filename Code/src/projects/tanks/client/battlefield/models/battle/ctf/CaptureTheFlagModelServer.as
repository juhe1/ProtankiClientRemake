package projects.tanks.client.battlefield.models.battle.ctf
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;

   public class CaptureTheFlagModelServer
   {

      private var model:IModel;

      public function CaptureTheFlagModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function dropFlagCommand() : void
      {
      }
   }
}
