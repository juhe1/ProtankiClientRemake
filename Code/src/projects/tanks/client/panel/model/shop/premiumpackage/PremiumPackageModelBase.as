package projects.tanks.client.panel.model.shop.premiumpackage
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class PremiumPackageModelBase extends Model
   {

      protected var server:PremiumPackageModelServer;

      public static const modelId:Long = Long.getLong(1196468726,1376782802);

      public function PremiumPackageModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new PremiumPackageModelServer(IModel(this));
      }

      protected function getInitParam() : PremiumPackageCC
      {
         return PremiumPackageCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
