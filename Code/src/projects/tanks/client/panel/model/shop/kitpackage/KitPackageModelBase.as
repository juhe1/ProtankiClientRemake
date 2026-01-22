package projects.tanks.client.panel.model.shop.kitpackage
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class KitPackageModelBase extends Model
   {

      protected var server:KitPackageModelServer;

      public static const modelId:Long = Long.getLong(489713493,1452551182);

      public function KitPackageModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new KitPackageModelServer(IModel(this));
      }

      protected function getInitParam() : KitPackageCC
      {
         return KitPackageCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
