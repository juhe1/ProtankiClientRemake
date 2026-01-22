package projects.tanks.client.panel.model.garage.availableitems
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class AvailableItemsModelBase extends Model
   {

      protected var server:AvailableItemsModelServer;

      public static const modelId:Long = Long.getLong(1203966282,1135370561);

      public function AvailableItemsModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new AvailableItemsModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
