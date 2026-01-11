package projects.tanks.client.battlefield.models.statistics.targetingmode
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class TargetingStatisticsModelBase extends Model
   {

      protected var server:TargetingStatisticsModelServer;

      public static const modelId:Long = Long.getLong(2097029315,-1445393748);

      public function TargetingStatisticsModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new TargetingStatisticsModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
