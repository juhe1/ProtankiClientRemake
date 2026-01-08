package projects.tanks.client.battlefield.models.statistics
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;

   public class MemoryStatisticsModelServer
   {

      private var model:IModel;

      public function MemoryStatisticsModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function collect(param1:Boolean, param2:int) : void
      {
      }
   }
}
