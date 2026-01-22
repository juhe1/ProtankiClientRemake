package projects.tanks.client.panel.model.donationalert
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;

   public class DonationAlertModelServer
   {

      private var model:IModel;

      public function DonationAlertModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function confirm(param1:Long) : void
      {
      }

      public function confirmWithEmail(param1:Long, param2:String) : void
      {
      }

      public function validateEmail(param1:String) : void
      {
      }
   }
}
