package projects.tanks.client.panel.model.rankupbonus.alert
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class RankUpBonusAlertPanelModelBase extends Model
   {

      protected var server:RankUpBonusAlertPanelModelServer;

      public static const modelId:Long = Long.getLong(1984500447,-1883224146);

      public function RankUpBonusAlertPanelModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new RankUpBonusAlertPanelModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
