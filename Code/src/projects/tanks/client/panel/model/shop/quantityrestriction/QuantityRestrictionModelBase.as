package projects.tanks.client.panel.model.shop.quantityrestriction
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class QuantityRestrictionModelBase extends Model
   {

      protected var server:QuantityRestrictionModelServer;

      public static const modelId:Long = Long.getLong(1770193848,-618385804);

      public function QuantityRestrictionModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new QuantityRestrictionModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
