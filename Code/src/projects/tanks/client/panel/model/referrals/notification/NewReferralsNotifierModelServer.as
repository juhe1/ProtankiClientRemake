package projects.tanks.client.panel.model.referrals.notification
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;

   public class NewReferralsNotifierModelServer
   {

      private var model:IModel;

      public function NewReferralsNotifierModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function requestNewReferralsCount() : void
      {
      }

      public function resetNewReferralsCount() : void
      {
      }
   }
}
