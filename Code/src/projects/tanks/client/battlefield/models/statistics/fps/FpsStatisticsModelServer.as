package projects.tanks.client.battlefield.models.statistics.fps
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;

   public class FpsStatisticsModelServer
   {

      private var model:IModel;

      public function FpsStatisticsModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function collectStatistics(param1:int, param2:int, param3:int) : void
      {
      }
   }
}
