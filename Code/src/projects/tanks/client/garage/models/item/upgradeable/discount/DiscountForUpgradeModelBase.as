package projects.tanks.client.garage.models.item.upgradeable.discount
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   import projects.tanks.client.garage.models.item.upgradeable.discount.DiscountForUpgradeModelServer;
   
   public class DiscountForUpgradeModelBase extends Model
   {
      public static const modelId:Long = Long.getLong(728120764,157623916);
      
      protected var server:DiscountForUpgradeModelServer;
      
      public function DiscountForUpgradeModelBase()
      {
         super();
         this.server = new DiscountForUpgradeModelServer(IModel(this));
      }
      
      override public function get id() : Long
      {
         return modelId;
      }
   }
}

