package projects.tanks.client.entrance.model.entrance.newbie
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;

   public class NewbieRegistrationModelServer
   {

      private var model:IModel;

      public function NewbieRegistrationModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function markUserAsNewbie() : void
      {
      }
   }
}
