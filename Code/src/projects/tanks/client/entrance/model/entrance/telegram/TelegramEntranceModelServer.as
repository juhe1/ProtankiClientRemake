package projects.tanks.client.entrance.model.entrance.telegram
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;

   public class TelegramEntranceModelServer
   {

      private var model:IModel;

      public function TelegramEntranceModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function login(param1:String) : void
      {
      }
   }
}
