package projects.tanks.client.battlefield.models.battle.battlefield
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class BattlefieldModelBase extends Model
   {

      protected var server:BattlefieldModelServer;

      public static const modelId:Long = Long.getLong(1723277227,1936126557);

      public function BattlefieldModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new BattlefieldModelServer(IModel(this));
      }

      protected function getInitParam() : BattlefieldCC
      {
         return BattlefieldCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
