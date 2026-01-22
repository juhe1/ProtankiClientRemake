package projects.tanks.client.panel.model.shop.specialkit
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class SpecialKitPackageModelBase extends Model
   {

      protected var server:SpecialKitPackageModelServer;

      public static const modelId:Long = Long.getLong(1441895147,1264370554);

      public function SpecialKitPackageModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new SpecialKitPackageModelServer(IModel(this));
      }

      protected function getInitParam() : SpecialKitPackageCC
      {
         return SpecialKitPackageCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
