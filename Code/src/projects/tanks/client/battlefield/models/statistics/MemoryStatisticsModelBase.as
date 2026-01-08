package projects.tanks.client.battlefield.models.statistics
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class MemoryStatisticsModelBase extends Model
   {

      protected var server:MemoryStatisticsModelServer;

      private static const modelId:Long = Long.getLong(2138145909,-1607792064);

      public function MemoryStatisticsModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new MemoryStatisticsModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
