package projects.tanks.client.battleselect.model.battle
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class BattleInfoModelBase extends Model
   {

      protected var server:BattleInfoModelServer;

      public static const modelId:Long = Long.getLong(678248814,-1039722970);

      public function BattleInfoModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new BattleInfoModelServer(IModel(this));
      }

      protected function getInitParam() : BattleInfoCC
      {
         return BattleInfoCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
