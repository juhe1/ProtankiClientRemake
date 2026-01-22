package projects.tanks.client.panel.model.shop.lootbox
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class LootBoxPackageModelBase extends Model
   {

      protected var server:LootBoxPackageModelServer;

      public static const modelId:Long = Long.getLong(2038557905,1696344636);

      public function LootBoxPackageModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new LootBoxPackageModelServer(IModel(this));
      }

      protected function getInitParam() : LootBoxPackageCC
      {
         return LootBoxPackageCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
