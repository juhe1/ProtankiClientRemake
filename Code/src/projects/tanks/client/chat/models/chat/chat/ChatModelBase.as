package projects.tanks.client.chat.models.chat.chat
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class ChatModelBase extends Model
   {

      protected var server:ChatModelServer;

      public static const modelId:Long = Long.getLong(1413646454,-1397687631);

      public function ChatModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new ChatModelServer(IModel(this));
      }

      protected function getInitParam() : ChatCC
      {
         return ChatCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
