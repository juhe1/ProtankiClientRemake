package projects.tanks.client.garage.models.item.view
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   import projects.tanks.client.garage.models.item.view.ItemViewCategoryCC;

   public class ItemViewCategoryModelBase extends Model
   {
      public static const modelId:Long = Long.getLong(1424296501,-807048170);

      protected var server:ItemViewCategoryModelServer;

      public function ItemViewCategoryModelBase()
      {
         super();
         this.server = new ItemViewCategoryModelServer(IModel(this));
      }

      protected function getInitParam() : ItemViewCategoryCC
      {
         return ItemViewCategoryCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
