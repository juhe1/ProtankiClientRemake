package projects.tanks.client.battlefield.models.bonus.battle.battlefield
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class BattlefieldBonusesModelBase extends Model
   {

      protected var server:BattlefieldBonusesModelServer;

      private static const modelId:Long = Long.getLong(499495185,-1001709329);

      public function BattlefieldBonusesModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new BattlefieldBonusesModelServer(IModel(this));
      }

      protected function getInitParam() : BattlefieldBonusesCC
      {
         return BattlefieldBonusesCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
