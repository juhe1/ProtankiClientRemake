package projects.tanks.client.battleselect.model.battle.entrance
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class BattleEntranceModelBase extends Model
   {

      protected var server:BattleEntranceModelServer;

      public static const modelId:Long = Long.getLong(124040719,-2122162804);

      public function BattleEntranceModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new BattleEntranceModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
