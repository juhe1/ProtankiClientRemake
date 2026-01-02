package projects.tanks.client.garage.models.item.itempersonaldiscount
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   import projects.tanks.client.garage.models.item.itempersonaldiscount.ItemPersonalDiscountCC;
   import projects.tanks.client.garage.models.item.itempersonaldiscount.ItemPersonalDiscountModelServer;
   
   public class ItemPersonalDiscountModelBase extends Model
   {
      public static const modelId:Long = Long.getLong(1297980728,-1710036775);
      
      protected var server:ItemPersonalDiscountModelServer;
      
      public function ItemPersonalDiscountModelBase()
      {
         super();
         this.server = new ItemPersonalDiscountModelServer(IModel(this));
      }
      
      protected function getInitParam() : ItemPersonalDiscountCC
      {
         return ItemPersonalDiscountCC(initParams[Model.object]);
      }
      
      override public function get id() : Long
      {
         return modelId;
      }
   }
}

