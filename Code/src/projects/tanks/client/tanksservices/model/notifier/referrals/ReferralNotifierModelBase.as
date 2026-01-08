package projects.tanks.client.tanksservices.model.notifier.referrals
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class ReferralNotifierModelBase extends Model
   {
      public static const modelId:Long = Long.getLong(1904649067,-739596764);

      protected var server:ReferralNotifierModelServer;

      public function ReferralNotifierModelBase()
      {
         super();
         this.server = new ReferralNotifierModelServer(IModel(this));
      }

      protected function getInitParam() : ReferralNotifierData
      {
         return ReferralNotifierData(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
