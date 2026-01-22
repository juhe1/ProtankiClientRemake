package projects.tanks.client.tanksservices.model.notifier.battle
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class BattleNotifierModelBase extends Model
   {

      protected var server:BattleNotifierModelServer;

      public static const modelId:Long = Long.getLong(904565121,-177943041);

      public function BattleNotifierModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new BattleNotifierModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
