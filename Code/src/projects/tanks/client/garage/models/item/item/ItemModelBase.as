package projects.tanks.client.garage.models.item.item
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   import projects.tanks.client.garage.models.item.item.ItemModelCC;
   import projects.tanks.client.garage.models.item.item.ItemModelServer;
   
   public class ItemModelBase extends Model
   {
      public static const modelId:Long = Long.getLong(800589377,840038407);
      
      protected var server:ItemModelServer;
      
      public function ItemModelBase()
      {
         super();
         this.server = new ItemModelServer(IModel(this));
      }
      
      protected function getInitParam() : ItemModelCC
      {
         return ItemModelCC(initParams[Model.object]);
      }
      
      override public function get id() : Long
      {
         return modelId;
      }
   }
}

