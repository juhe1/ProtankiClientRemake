package projects.tanks.client.battleselect.model.matchmaking.grouplifecycle
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class MatchmakingGroupLifecycleModelBase extends Model
   {

      protected var server:MatchmakingGroupLifecycleModelServer;

      public static const modelId:Long = Long.getLong(413804305,1147765830);

      public function MatchmakingGroupLifecycleModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new MatchmakingGroupLifecycleModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
