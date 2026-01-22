package projects.tanks.client.panel.model.shop.paintpackage
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class PaintPackageModelBase extends Model
   {

      protected var server:PaintPackageModelServer;

      public static const modelId:Long = Long.getLong(1834980457,690531570);

      public function PaintPackageModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new PaintPackageModelServer(IModel(this));
      }

      protected function getInitParam() : PaintPackageCC
      {
         return PaintPackageCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
