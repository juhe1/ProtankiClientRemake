package projects.tanks.client.battlefield.models.bonus.battle.bonusregions
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class BonusRegionsModelBase extends Model
   {

      protected var server:BonusRegionsModelServer;

      private static const modelId:Long = Long.getLong(1214265883,963276324);

      public function BonusRegionsModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new BonusRegionsModelServer(IModel(this));
      }

      protected function getInitParam() : BonusRegionsCC
      {
         return BonusRegionsCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
