package projects.tanks.client.battleselect.model.matchmaking.notify
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class MatchmakingNotifyModelBase extends Model
   {

      protected var server:MatchmakingNotifyModelServer;

      public static const modelId:Long = Long.getLong(1668041838,-577067222);

      public function MatchmakingNotifyModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new MatchmakingNotifyModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
