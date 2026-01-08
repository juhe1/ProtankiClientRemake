package projects.tanks.client.entrance.model.entrance.partners
{
   import platform.client.core.general.socialnetwork.types.LoginParameters;
   import platform.client.fp10.core.model.IModel;

   public class CompositePartnerModelServer
   {
      private var model:IModel;

      public function CompositePartnerModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function bindAccount(param1:String, param2:String) : void
      {
      }

      public function finishRegistration(param1:String, param2:String) : void
      {
      }

      public function loadPartnerObjectOnClient(param1:String) : void
      {
      }

      public function loginViaPartner(param1:String, param2:LoginParameters) : void
      {
      }
   }
}
