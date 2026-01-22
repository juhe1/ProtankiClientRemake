package projects.tanks.client.battleselect.model.matchmaking.view
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class MatchmakingLayoutModelBase extends Model
   {

      protected var server:MatchmakingLayoutModelServer;

      public static const modelId:Long = Long.getLong(1381232317,979335603);

      public function MatchmakingLayoutModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new MatchmakingLayoutModelServer(IModel(this));
      }

      protected function getInitParam() : MatchmakingLayoutCC
      {
         return MatchmakingLayoutCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
