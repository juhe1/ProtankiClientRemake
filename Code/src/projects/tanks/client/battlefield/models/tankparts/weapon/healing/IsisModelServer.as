package projects.tanks.client.battlefield.models.tankparts.weapon.healing
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battlefield.types.Vector3d;

   public class IsisModelServer
   {

      private var model:IModel;

      public function IsisModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function resetTarget(param1:int) : void
      {
      }

      public function setTarget(param1:int, param2:IGameObject, param3:int, param4:Vector3d) : void
      {
      }

      public function stopWeaponCommand(param1:int) : void
      {
      }

      public function tickCommand(param1:int, param2:int, param3:Vector3d, param4:Vector3d) : void
      {
      }
   }
}
