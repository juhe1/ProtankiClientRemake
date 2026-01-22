package projects.tanks.client.chat.models.clanchat.clanchat
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;

   public class ClanChatModelServer
   {

      private var model:IModel;

      public function ClanChatModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function sendMessage(param1:String, param2:String) : void
      {
      }
   }
}
