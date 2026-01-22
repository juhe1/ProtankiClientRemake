package projects.tanks.client.battleselect.model.battle.param
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class BattleParamInfoModelBase extends Model
   {

      protected var server:BattleParamInfoModelServer;

      public static const modelId:Long = Long.getLong(1462665762,397983152);

      public function BattleParamInfoModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new BattleParamInfoModelServer(IModel(this));
      }

      protected function getInitParam() : BattleParamInfoCC
      {
         return BattleParamInfoCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
