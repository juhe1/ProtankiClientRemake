package projects.tanks.client.garage.models.item.grouped
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   import projects.tanks.client.garage.models.item.grouped.GroupedCC;
   import projects.tanks.client.garage.models.item.grouped.GroupedItemModelServer;
   
   public class GroupedItemModelBase extends Model
   {
      public static const modelId:Long = Long.getLong(434340673,532838092);
      
      protected var server:GroupedItemModelServer;
      
      public function GroupedItemModelBase()
      {
         super();
         this.server = new GroupedItemModelServer(IModel(this));
      }
      
      protected function getInitParam() : GroupedCC
      {
         return GroupedCC(initParams[Model.object]);
      }
      
      override public function get id() : Long
      {
         return modelId;
      }
   }
}

