package projects.tanks.client.garage.models.item.itemforpartners
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   import projects.tanks.client.garage.models.item.itemforpartners.ItemEnabledForPartnerCC;
   import projects.tanks.client.garage.models.item.itemforpartners.ItemEnabledForPartnerModelServer;
   
   public class ItemEnabledForPartnerModelBase extends Model
   {
      public static const modelId:Long = Long.getLong(49746997,526537269);
      
      protected var server:ItemEnabledForPartnerModelServer;
      
      public function ItemEnabledForPartnerModelBase()
      {
         super();
         this.server = new ItemEnabledForPartnerModelServer(IModel(this));
      }
      
      protected function getInitParam() : ItemEnabledForPartnerCC
      {
         return ItemEnabledForPartnerCC(initParams[Model.object]);
      }
      
      override public function get id() : Long
      {
         return modelId;
      }
   }
}

