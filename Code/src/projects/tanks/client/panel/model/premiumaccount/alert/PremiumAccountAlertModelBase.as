package projects.tanks.client.panel.model.premiumaccount.alert
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class PremiumAccountAlertModelBase extends Model
   {

      protected var server:PremiumAccountAlertModelServer;

      public static const modelId:Long = Long.getLong(287111968,-1381886380);

      public function PremiumAccountAlertModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new PremiumAccountAlertModelServer(IModel(this));
      }

      protected function getInitParam() : PremiumAccountAlertCC
      {
         return PremiumAccountAlertCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
