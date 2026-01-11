package projects.tanks.client.battlefield.models.continuebattle
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class MatchmakingContinueBattleModelBase extends Model
   {

      protected var server:MatchmakingContinueBattleModelServer;

      public static const modelId:Long = Long.getLong(451825136,-2117628925);

      public function MatchmakingContinueBattleModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new MatchmakingContinueBattleModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
