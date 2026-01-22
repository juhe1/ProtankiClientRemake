package projects.tanks.client.clans.user.incomingnotificator
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;

   public class ClanUserIncomingNotificatorModelServer
   {

      private var model:IModel;

      public function ClanUserIncomingNotificatorModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function removeNotification(param1:IGameObject) : void
      {
      }
   }
}
