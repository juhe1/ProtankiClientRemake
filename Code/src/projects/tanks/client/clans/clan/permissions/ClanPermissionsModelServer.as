package projects.tanks.client.clans.clan.permissions
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;

   public class ClanPermissionsModelServer
   {

      private var model:IModel;

      public function ClanPermissionsModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function setPermissionForUser(param1:Long, param2:ClanPermission) : void
      {
      }
   }
}
