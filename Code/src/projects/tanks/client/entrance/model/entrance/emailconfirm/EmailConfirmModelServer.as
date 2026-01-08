package projects.tanks.client.entrance.model.entrance.emailconfirm
{
   import platform.client.fp10.core.model.IModel;

   public class EmailConfirmModelServer
   {  
      private var model:IModel;

      public function EmailConfirmModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function confirmEmail(param1:String, param2:String) : void
      {
      }
   }
}
