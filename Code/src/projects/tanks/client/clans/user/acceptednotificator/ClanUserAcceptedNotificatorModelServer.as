package projects.tanks.client.clans.user.acceptednotificator
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;

   public class ClanUserAcceptedNotificatorModelServer
   {

      private var model:IModel;

      public function ClanUserAcceptedNotificatorModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function removeNotification(param1:Long) : void
      {
      }
   }
}
