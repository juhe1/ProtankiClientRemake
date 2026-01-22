package projects.tanks.client.panel.model.battleinvite
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class BattleInviteModelBase extends Model
   {

      protected var server:BattleInviteModelServer;

      public static const modelId:Long = Long.getLong(1766933086,508742652);

      public function BattleInviteModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new BattleInviteModelServer(IModel(this));
      }

      protected function getInitParam() : BattleInviteCC
      {
         return BattleInviteCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
