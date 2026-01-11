package projects.tanks.client.battlefield.models.battle.battlefield.debug
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class BattleDebugModelBase extends Model
   {

      protected var server:BattleDebugModelServer;

      public static const modelId:Long = Long.getLong(779331045,19368635);

      public function BattleDebugModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new BattleDebugModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
