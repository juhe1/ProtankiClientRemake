package projects.tanks.client.commons.models.layout.notify
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class LobbyLayoutNotifyModelBase extends Model
   {

      protected var server:LobbyLayoutNotifyModelServer;

      public static const modelId:Long = Long.getLong(1481647778,-291699533);

      public function LobbyLayoutNotifyModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new LobbyLayoutNotifyModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
