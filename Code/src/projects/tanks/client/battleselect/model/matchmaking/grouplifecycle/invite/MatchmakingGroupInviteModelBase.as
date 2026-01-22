package projects.tanks.client.battleselect.model.matchmaking.grouplifecycle.invite
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class MatchmakingGroupInviteModelBase extends Model
   {

      protected var server:MatchmakingGroupInviteModelServer;

      public static const modelId:Long = Long.getLong(1554280211,1562501796);

      public function MatchmakingGroupInviteModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new MatchmakingGroupInviteModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
