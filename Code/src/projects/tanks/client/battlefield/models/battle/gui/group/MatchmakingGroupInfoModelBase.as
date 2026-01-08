package projects.tanks.client.battlefield.models.battle.gui.group
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class MatchmakingGroupInfoModelBase extends Model
   {

      protected var server:MatchmakingGroupInfoModelServer;

      private static const modelId:Long = Long.getLong(1776691703,-1828525018);

      public function MatchmakingGroupInfoModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new MatchmakingGroupInfoModelServer(IModel(this));
      }

      protected function getInitParam() : MatchmakingGroupInfoCC
      {
         return MatchmakingGroupInfoCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
