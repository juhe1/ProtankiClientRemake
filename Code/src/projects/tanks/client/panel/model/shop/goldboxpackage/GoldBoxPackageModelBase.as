package projects.tanks.client.panel.model.shop.goldboxpackage
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class GoldBoxPackageModelBase extends Model
   {

      protected var server:GoldBoxPackageModelServer;

      public static const modelId:Long = Long.getLong(187691348,-230913842);

      public function GoldBoxPackageModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new GoldBoxPackageModelServer(IModel(this));
      }

      protected function getInitParam() : GoldBoxPackageCC
      {
         return GoldBoxPackageCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
