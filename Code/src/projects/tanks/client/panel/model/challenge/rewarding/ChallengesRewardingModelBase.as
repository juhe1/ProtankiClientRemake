package projects.tanks.client.panel.model.challenge.rewarding
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class ChallengesRewardingModelBase extends Model
   {

      protected var server:ChallengesRewardingModelServer;

      public static const modelId:Long = Long.getLong(1504901702,408311149);

      public function ChallengesRewardingModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new ChallengesRewardingModelServer(IModel(this));
      }

      protected function getInitParam() : ChallengeRewardsCC
      {
         return ChallengeRewardsCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
