package projects.tanks.client.garage.models.item.properties
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   import projects.tanks.client.garage.models.item.properties.ItemPropertiesCC;

   public class ItemPropertiesModelBase extends Model
   {
      public static const modelId:Long = Long.getLong(988366120,-592971316);

      protected var server:ItemPropertiesModelServer;

      public function ItemPropertiesModelBase()
      {
         super();
         this.server = new ItemPropertiesModelServer(IModel(this));
      }

      protected function getInitParam() : ItemPropertiesCC
      {
         return ItemPropertiesCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
