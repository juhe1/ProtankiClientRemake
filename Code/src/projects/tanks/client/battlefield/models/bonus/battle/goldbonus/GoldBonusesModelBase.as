package projects.tanks.client.battlefield.models.bonus.battle.goldbonus
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class GoldBonusesModelBase extends Model
   {

      protected var server:GoldBonusesModelServer;

      private static const modelId:Long = Long.getLong(777565245,-2042440396);

      public function GoldBonusesModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new GoldBonusesModelServer(IModel(this));
      }

      protected function getInitParam() : GoldBonusCC
      {
         return GoldBonusCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
