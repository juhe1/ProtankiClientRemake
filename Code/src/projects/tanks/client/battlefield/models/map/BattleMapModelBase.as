package projects.tanks.client.battlefield.models.map
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class BattleMapModelBase extends Model
   {

      protected var server:BattleMapModelServer;

      public static const modelId:Long = Long.getLong(1092696378,-225264163);

      public function BattleMapModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new BattleMapModelServer(IModel(this));
      }

      protected function getInitParam() : BattleMapCC
      {
         return BattleMapCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
