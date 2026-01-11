package projects.tanks.client.battlefield.models.tankparts.gearscore
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class BattleGearScoreModelBase extends Model
   {

      protected var server:BattleGearScoreModelServer;

      public static const modelId:Long = Long.getLong(1135202411,-1956043623);

      public function BattleGearScoreModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new BattleGearScoreModelServer(IModel(this));
      }

      protected function getInitParam() : BattleGearScoreCC
      {
         return BattleGearScoreCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
