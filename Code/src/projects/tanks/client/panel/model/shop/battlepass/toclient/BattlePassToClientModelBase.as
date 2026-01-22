package projects.tanks.client.panel.model.shop.battlepass.toclient
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class BattlePassToClientModelBase extends Model
   {

      protected var server:BattlePassToClientModelServer;

      public static const modelId:Long = Long.getLong(725013772,-1318273728);

      public function BattlePassToClientModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new BattlePassToClientModelServer(IModel(this));
      }

      protected function getInitParam() : BattlePassToClientCC
      {
         return BattlePassToClientCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
