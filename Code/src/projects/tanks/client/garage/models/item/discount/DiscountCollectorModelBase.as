package projects.tanks.client.garage.models.item.discount
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class DiscountCollectorModelBase extends Model
   {
      public static const modelId:Long = Long.getLong(1896140971,-1323660734);

      protected var server:DiscountCollectorModelServer;

      public function DiscountCollectorModelBase()
      {
         super();
         this.server = new DiscountCollectorModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
