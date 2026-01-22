package projects.tanks.client.panel.model.referrals.notification
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class NewReferralsNotifierModelBase extends Model
   {

      protected var server:NewReferralsNotifierModelServer;

      public static const modelId:Long = Long.getLong(1159964427,-343700957);

      public function NewReferralsNotifierModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new NewReferralsNotifierModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
