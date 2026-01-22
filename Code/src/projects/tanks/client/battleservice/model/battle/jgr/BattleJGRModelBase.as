package projects.tanks.client.battleservice.model.battle.jgr
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class BattleJGRModelBase extends Model
   {

      protected var server:BattleJGRModelServer;

      public static const modelId:Long = Long.getLong(1189086764,-465610899);

      public function BattleJGRModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new BattleJGRModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
