package projects.tanks.client.battlefield.models.tankparts.weapon.freeze
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battlefield.types.Vector3d;

   public class FreezeModelServer
   {

      private var model:IModel;

      public function FreezeModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function dryShot(param1:int) : void
      {
      }

      public function hitCommand(param1:int, param2:Vector.<IGameObject>, param3:Vector.<int>, param4:Vector.<Vector3d>, param5:Vector.<Vector3d>) : void
      {
      }

      public function startFireCommand(param1:int) : void
      {
      }

      public function stopFireCommand(param1:int) : void
      {
      }
   }
}
