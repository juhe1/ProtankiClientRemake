package projects.tanks.client.battlefield.models.bonus.bonus.battlebonuses.crystal
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class BattleGoldBonusesModelBase extends Model
   {

      protected var server:BattleGoldBonusesModelServer;

      public static const modelId:Long = Long.getLong(118876660,-1267889929);

      public function BattleGoldBonusesModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new BattleGoldBonusesModelServer(IModel(this));
      }

      protected function getInitParam() : BattleGoldBonusCC
      {
         return BattleGoldBonusCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
