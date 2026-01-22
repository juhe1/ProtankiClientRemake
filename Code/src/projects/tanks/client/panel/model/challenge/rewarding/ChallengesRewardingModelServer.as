package projects.tanks.client.panel.model.challenge.rewarding
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;

   public class ChallengesRewardingModelServer
   {

      private var model:IModel;

      public function ChallengesRewardingModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function requestTiersInfo() : void
      {
      }
   }
}
