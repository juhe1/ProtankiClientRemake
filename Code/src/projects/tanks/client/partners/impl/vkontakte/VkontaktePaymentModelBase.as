package projects.tanks.client.partners.impl.vkontakte
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class VkontaktePaymentModelBase extends Model
   {

      protected var server:VkontaktePaymentModelServer;

      public static const modelId:Long = Long.getLong(982237961,270527442);

      public function VkontaktePaymentModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new VkontaktePaymentModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
