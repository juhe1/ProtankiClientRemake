package projects.tanks.client.garage.models.item.upgradeable
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   import projects.tanks.client.garage.models.item.upgradeable.UpgradeParamsCC;

   public class UpgradeableParamsConstructorModelBase extends Model
   {
      public static const modelId:Long = Long.getLong(1104447849,1721128071);

      protected var server:UpgradeableParamsConstructorModelServer;

      public function UpgradeableParamsConstructorModelBase()
      {
         super();
         this.server = new UpgradeableParamsConstructorModelServer(IModel(this));
      }

      protected function getInitParam() : UpgradeParamsCC
      {
         return UpgradeParamsCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
