package projects.tanks.client.panel.model.videoads.videoadsbattleresult
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class VideoAdsBattleResultModelBase extends Model
   {

      protected var server:VideoAdsBattleResultModelServer;

      public static const modelId:Long = Long.getLong(549828790,1245365939);

      public function VideoAdsBattleResultModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new VideoAdsBattleResultModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
