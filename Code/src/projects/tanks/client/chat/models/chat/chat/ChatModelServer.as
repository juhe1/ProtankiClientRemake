package projects.tanks.client.chat.models.chat.chat
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;

   public class ChatModelServer
   {

      private var model:IModel;

      public function ChatModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function changeChannel(param1:String) : void
      {
      }

      public function sendMessage(param1:String, param2:ChatAddressMode, param3:String, param4:String) : void
      {
      }
   }
}
