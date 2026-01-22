package projects.tanks.client.battleselect.model.matchmaking.spectator
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class MatchmakingSpectatorEntranceModelBase extends Model
   {

      protected var server:MatchmakingSpectatorEntranceModelServer;

      public static const modelId:Long = Long.getLong(2143871783,-1643323062);

      public function MatchmakingSpectatorEntranceModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new MatchmakingSpectatorEntranceModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
