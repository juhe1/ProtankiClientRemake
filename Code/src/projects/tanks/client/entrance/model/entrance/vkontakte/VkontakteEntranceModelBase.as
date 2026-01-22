package projects.tanks.client.entrance.model.entrance.vkontakte
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class VkontakteEntranceModelBase extends Model
   {

      protected var server:VkontakteEntranceModelServer;

      public static const modelId:Long = Long.getLong(1006312626,1716761864);

      public function VkontakteEntranceModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new VkontakteEntranceModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
