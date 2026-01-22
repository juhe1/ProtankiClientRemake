package projects.tanks.client.tanksservices.model.proabonementnotifier
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class ProBattleNotifierModelBase extends Model
   {

      protected var server:ProBattleNotifierModelServer;

      public static const modelId:Long = Long.getLong(1634466802,-928935342);

      public function ProBattleNotifierModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new ProBattleNotifierModelServer(IModel(this));
      }

      protected function getInitParam() : ProAbonementNotifierCC
      {
         return ProAbonementNotifierCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
