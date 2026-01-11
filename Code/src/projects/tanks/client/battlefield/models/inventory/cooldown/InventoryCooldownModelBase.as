package projects.tanks.client.battlefield.models.inventory.cooldown
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class InventoryCooldownModelBase extends Model
   {

      protected var server:InventoryCooldownModelServer;

      public static const modelId:Long = Long.getLong(169566618,2066569805);

      public function InventoryCooldownModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new InventoryCooldownModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
