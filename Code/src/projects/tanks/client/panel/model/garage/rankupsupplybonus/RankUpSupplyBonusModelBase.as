package projects.tanks.client.panel.model.garage.rankupsupplybonus
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class RankUpSupplyBonusModelBase extends Model
   {

      protected var server:RankUpSupplyBonusModelServer;

      public static const modelId:Long = Long.getLong(1175442844,-1652512683);

      public function RankUpSupplyBonusModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new RankUpSupplyBonusModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
