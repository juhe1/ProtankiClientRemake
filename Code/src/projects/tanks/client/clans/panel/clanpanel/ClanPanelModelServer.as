package projects.tanks.client.clans.panel.clanpanel
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;

   public class ClanPanelModelServer
   {

      private var model:IModel;

      public function ClanPanelModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function sendInviteToClan(param1:Long) : void
      {
      }
   }
}
