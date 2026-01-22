package projects.tanks.client.chat.models
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class CommunicationPanelModelBase extends Model
   {

      protected var server:CommunicationPanelModelServer;

      public static const modelId:Long = Long.getLong(849948908,-833351099);

      public function CommunicationPanelModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new CommunicationPanelModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
