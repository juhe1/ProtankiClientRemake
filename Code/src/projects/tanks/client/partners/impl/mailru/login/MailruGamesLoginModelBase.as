package projects.tanks.client.partners.impl.mailru.login
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class MailruGamesLoginModelBase extends Model
   {

      protected var server:MailruGamesLoginModelServer;

      public static const modelId:Long = Long.getLong(552799900,1953964629);

      public function MailruGamesLoginModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new MailruGamesLoginModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
