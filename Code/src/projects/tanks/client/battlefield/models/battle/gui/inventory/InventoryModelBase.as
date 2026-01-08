package projects.tanks.client.battlefield.models.battle.gui.inventory
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class InventoryModelBase extends Model
   {

      protected var server:InventoryModelServer;

      private static const modelId:Long = Long.getLong(1500686585,-1760437566);

      public function InventoryModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new InventoryModelServer(IModel(this));
      }

      protected function getInitParam() : InventoryCC
      {
         return InventoryCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
