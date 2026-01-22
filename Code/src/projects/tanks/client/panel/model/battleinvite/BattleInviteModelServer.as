package projects.tanks.client.panel.model.battleinvite
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;

   public class BattleInviteModelServer
   {

      private var model:IModel;

      public function BattleInviteModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function accept(param1:String) : void
      {
      }

      public function invite(param1:String, param2:String) : void
      {
      }

      public function reject(param1:String) : void
      {
      }
   }
}
