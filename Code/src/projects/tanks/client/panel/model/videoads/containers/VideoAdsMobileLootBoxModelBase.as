package projects.tanks.client.panel.model.videoads.containers
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class VideoAdsMobileLootBoxModelBase extends Model
   {

      protected var server:VideoAdsMobileLootBoxModelServer;

      public static const modelId:Long = Long.getLong(6647106,-1564678751);

      public function VideoAdsMobileLootBoxModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new VideoAdsMobileLootBoxModelServer(IModel(this));
      }

      protected function getInitParam() : VideoAdsMobileLootBoxCC
      {
         return VideoAdsMobileLootBoxCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
