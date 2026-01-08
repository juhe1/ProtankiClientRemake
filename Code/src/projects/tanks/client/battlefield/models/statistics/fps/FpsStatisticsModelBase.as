package projects.tanks.client.battlefield.models.statistics.fps
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class FpsStatisticsModelBase extends Model
   {

      protected var server:FpsStatisticsModelServer;

      private static const modelId:Long = Long.getLong(1377034498,-1539317145);

      public function FpsStatisticsModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new FpsStatisticsModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
