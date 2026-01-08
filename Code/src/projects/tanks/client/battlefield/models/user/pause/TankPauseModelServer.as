package projects.tanks.client.battlefield.models.user.pause
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;

   public class TankPauseModelServer
   {

      private var model:IModel;

      public function TankPauseModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function disablePause() : void
      {
      }
   }
}
