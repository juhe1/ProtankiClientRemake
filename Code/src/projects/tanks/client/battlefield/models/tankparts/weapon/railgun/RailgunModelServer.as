package projects.tanks.client.battlefield.models.tankparts.weapon.railgun
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battlefield.types.Vector3d;

   public class RailgunModelServer
   {

      private var model:IModel;

      public function RailgunModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function fireCommand(param1:int, param2:Vector3d, param3:Vector.<IGameObject>, param4:Vector.<Vector3d>, param5:Vector.<int>, param6:Vector.<Vector3d>, param7:Vector.<Vector3d>) : void
      {
      }

      public function fireDummyCommand(param1:int) : void
      {
      }

      public function startChargingCommand(param1:int) : void
      {
      }
   }
}
