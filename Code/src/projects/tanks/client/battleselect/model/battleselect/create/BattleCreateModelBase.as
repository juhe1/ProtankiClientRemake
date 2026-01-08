package projects.tanks.client.battleselect.model.battleselect.create
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class BattleCreateModelBase extends Model
   {
      protected var server:BattleCreateModelServer;

      public static const modelId:Long = Long.getLong(2006601986,1009878384);

      public function BattleCreateModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new BattleCreateModelServer(IModel(this));
      }

      protected function getInitParam() : BattleCreateCC
      {
         return BattleCreateCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
