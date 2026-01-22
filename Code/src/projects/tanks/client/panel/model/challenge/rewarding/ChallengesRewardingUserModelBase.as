package projects.tanks.client.panel.model.challenge.rewarding
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class ChallengesRewardingUserModelBase extends Model
   {

      protected var server:ChallengesRewardingUserModelServer;

      public static const modelId:Long = Long.getLong(142490486,-1012948578);

      public function ChallengesRewardingUserModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new ChallengesRewardingUserModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
