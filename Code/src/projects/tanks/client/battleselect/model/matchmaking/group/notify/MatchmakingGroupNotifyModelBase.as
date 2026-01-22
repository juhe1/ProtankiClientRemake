package projects.tanks.client.battleselect.model.matchmaking.group.notify
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class MatchmakingGroupNotifyModelBase extends Model
   {

      protected var server:MatchmakingGroupNotifyModelServer;

      public static const modelId:Long = Long.getLong(24345264,-1141305498);

      public function MatchmakingGroupNotifyModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new MatchmakingGroupNotifyModelServer(IModel(this));
      }

      protected function getInitParam() : MatchmakingGroupCC
      {
         return MatchmakingGroupCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
