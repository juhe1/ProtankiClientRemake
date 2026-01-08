package projects.tanks.client.battleselect.model.battleselect
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class BattleSelectModelBase extends Model
   {
      protected var server:BattleSelectModelServer;

      public static const modelId:Long = Long.getLong(600945976,725191480);

      public function BattleSelectModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new BattleSelectModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
