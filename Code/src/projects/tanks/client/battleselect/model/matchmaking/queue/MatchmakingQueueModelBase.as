package projects.tanks.client.battleselect.model.matchmaking.queue
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class MatchmakingQueueModelBase extends Model
   {

      protected var server:MatchmakingQueueModelServer;

      public static const modelId:Long = Long.getLong(736490567,-734280032);

      public function MatchmakingQueueModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new MatchmakingQueueModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
