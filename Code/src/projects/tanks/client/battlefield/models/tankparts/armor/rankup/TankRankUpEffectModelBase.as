package projects.tanks.client.battlefield.models.tankparts.armor.rankup
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class TankRankUpEffectModelBase extends Model
   {

      protected var server:TankRankUpEffectModelServer;

      private static const modelId:Long = Long.getLong(1545673170,1705258317);

      public function TankRankUpEffectModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new TankRankUpEffectModelServer(IModel(this));
      }

      protected function getInitParam() : TankRankUpEffectCC
      {
         return TankRankUpEffectCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
