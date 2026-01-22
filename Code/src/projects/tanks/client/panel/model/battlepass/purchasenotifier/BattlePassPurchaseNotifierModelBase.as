package projects.tanks.client.panel.model.battlepass.purchasenotifier
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class BattlePassPurchaseNotifierModelBase extends Model
   {

      protected var server:BattlePassPurchaseNotifierModelServer;

      public static const modelId:Long = Long.getLong(664877248,-2049851574);

      public function BattlePassPurchaseNotifierModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new BattlePassPurchaseNotifierModelServer(IModel(this));
      }

      protected function getInitParam() : BattlePassPurchaseNotifierCC
      {
         return BattlePassPurchaseNotifierCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
