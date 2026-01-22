package projects.tanks.client.tanksservices.model.notifier.premium
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class PremiumNotifierModelBase extends Model
   {

      protected var server:PremiumNotifierModelServer;

      public static const modelId:Long = Long.getLong(302389563,-1379937773);

      public function PremiumNotifierModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new PremiumNotifierModelServer(IModel(this));
      }

      protected function getInitParam() : PremiumNotifierCC
      {
         return PremiumNotifierCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
