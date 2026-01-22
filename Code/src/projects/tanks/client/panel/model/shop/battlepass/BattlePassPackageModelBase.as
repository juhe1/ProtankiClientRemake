package projects.tanks.client.panel.model.shop.battlepass
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class BattlePassPackageModelBase extends Model
   {

      protected var server:BattlePassPackageModelServer;

      public static const modelId:Long = Long.getLong(1200454711,1970534342);

      public function BattlePassPackageModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new BattlePassPackageModelServer(IModel(this));
      }

      protected function getInitParam() : BattlePassPackageCC
      {
         return BattlePassPackageCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
