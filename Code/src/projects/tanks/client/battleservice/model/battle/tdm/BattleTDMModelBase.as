package projects.tanks.client.battleservice.model.battle.tdm
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class BattleTDMModelBase extends Model
   {

      protected var server:BattleTDMModelServer;

      public static const modelId:Long = Long.getLong(815932807,-684891581);

      public function BattleTDMModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new BattleTDMModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
