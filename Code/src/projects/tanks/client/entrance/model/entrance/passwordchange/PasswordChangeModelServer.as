package projects.tanks.client.entrance.model.entrance.passwordchange
{
   import platform.client.fp10.core.model.IModel;

   public class PasswordChangeModelServer
   {

      private var model:IModel;

      public function PasswordChangeModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function changePasswordAndEmail(param1:String, param2:String, param3:String) : void
      {
      }

      public function checkPasswordChangeHash(param1:String) : void
      {
      }

      public function resetChangePasswordHashAndEntranceHash(param1:String) : void
      {
      }

      public function sendUsersRestorePasswordLink(param1:String) : void
      {
      }
   }
}
