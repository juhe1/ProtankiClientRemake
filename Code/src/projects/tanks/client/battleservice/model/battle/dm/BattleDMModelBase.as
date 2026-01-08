package projects.tanks.client.battleservice.model.battle.dm
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class BattleDMModelBase extends Model
   {

      protected var server:BattleDMModelServer;

      private static const modelId:Long = Long.getLong(759725658,1071543601);

      public function BattleDMModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new BattleDMModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
