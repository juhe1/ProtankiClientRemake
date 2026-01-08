package projects.tanks.client.battlefield.models.battle.jgr.killstreak
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class KillStreakModelBase extends Model
   {

      protected var server:KillStreakModelServer;

      private static const modelId:Long = Long.getLong(1192985770,445553764);

      public function KillStreakModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new KillStreakModelServer(IModel(this));
      }

      protected function getInitParam() : KillStreakCC
      {
         return KillStreakCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
