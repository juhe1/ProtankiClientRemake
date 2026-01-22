package projects.tanks.client.chat.models.clanchat.clanchat
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class ClanChatModelBase extends Model
   {

      protected var server:ClanChatModelServer;

      public static const modelId:Long = Long.getLong(207484105,-2003218757);

      public function ClanChatModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new ClanChatModelServer(IModel(this));
      }

      protected function getInitParam() : ClanChatCC
      {
         return ClanChatCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
