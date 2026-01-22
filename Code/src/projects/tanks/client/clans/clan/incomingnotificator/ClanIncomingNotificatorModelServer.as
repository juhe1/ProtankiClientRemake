package projects.tanks.client.clans.clan.incomingnotificator
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;

   public class ClanIncomingNotificatorModelServer
   {

      private var model:IModel;

      public function ClanIncomingNotificatorModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function remove(param1:Long) : void
      {
      }
   }
}
