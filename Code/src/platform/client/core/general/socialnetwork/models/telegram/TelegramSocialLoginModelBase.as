package platform.client.core.general.socialnetwork.models.telegram
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class TelegramSocialLoginModelBase extends Model
   {

      protected var server:TelegramSocialLoginModelServer;

      public static const modelId:Long = Long.getLong(1704658995,-863360489);

      public function TelegramSocialLoginModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new TelegramSocialLoginModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
