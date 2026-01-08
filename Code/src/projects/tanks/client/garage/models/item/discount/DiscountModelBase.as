package projects.tanks.client.garage.models.item.discount
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   import projects.tanks.client.garage.models.item.discount.DiscountCC;

   public class DiscountModelBase extends Model
   {
      public static const modelId:Long = Long.getLong(687238537,2002147897);

      protected var server:DiscountModelServer;

      public function DiscountModelBase()
      {
         super();
         this.server = new DiscountModelServer(IModel(this));
      }

      protected function getInitParam() : DiscountCC
      {
         return DiscountCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
