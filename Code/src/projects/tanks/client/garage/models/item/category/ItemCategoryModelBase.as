package projects.tanks.client.garage.models.item.category
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   
   public class ItemCategoryModelBase extends Model
   {
      public static var modelId:Long = Long.getLong(492245786,-1837686060);
      
      protected var server:ItemCategoryModelServer;
      
      public function ItemCategoryModelBase()
      {
         super();
         this.server = new ItemCategoryModelServer(IModel(this));
      }
      
      protected function getInitParam() : ItemCategoryCC
      {
         return ItemCategoryCC(initParams[Model.object]);
      }
      
      override public function get id() : Long
      {
         return modelId;
      }
   }
}

