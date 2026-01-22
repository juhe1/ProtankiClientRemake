package projects.tanks.client.panel.model.shop.crystalpackage
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class CrystalPackageModelBase extends Model
   {

      protected var server:CrystalPackageModelServer;

      public static const modelId:Long = Long.getLong(649454538,1565941774);

      public function CrystalPackageModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new CrystalPackageModelServer(IModel(this));
      }

      protected function getInitParam() : CrystalPackageCC
      {
         return CrystalPackageCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
