package projects.tanks.client.tanksservices.model.reconnect
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;

   public class ReconnectModelServer
   {

      private var model:IModel;

      public function ReconnectModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function wantToReconnect() : void
      {
      }
   }
}
