package projects.tanks.client.battlefield.models.battle.battlefield.mine
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class BattleMinesModelBase extends Model
   {

      protected var server:BattleMinesModelServer;

      private static const modelId:Long = Long.getLong(479007306,2075268288);

      public function BattleMinesModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new BattleMinesModelServer(IModel(this));
      }

      protected function getInitParam() : BattleMineCC
      {
         return BattleMineCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
