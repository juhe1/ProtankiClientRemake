package projects.tanks.client.partners.impl.mailru.payment
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class MailruGamesPaymentModelBase extends Model
   {

      protected var server:MailruGamesPaymentModelServer;

      public static const modelId:Long = Long.getLong(588118997,-1972708299);

      public function MailruGamesPaymentModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new MailruGamesPaymentModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
