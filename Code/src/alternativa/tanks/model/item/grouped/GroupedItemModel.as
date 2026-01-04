package alternativa.tanks.model.item.grouped
{
   import projects.tanks.client.garage.models.item.grouped.GroupedItemModelBase;
   import projects.tanks.client.garage.models.item.grouped.IGroupedItemModelBase;
   import projects.tanks.client.garage.models.item.grouped.GroupedCC;
   
   [ModelInfo]
   public class GroupedItemModel extends GroupedItemModelBase implements IGroupedItemModelBase, IGroupedItem
   {
      
      public function GroupedItemModel()
      {
         super();
      }
      
      public function isGrouped() : Boolean
      {
         var initParam:GroupedCC = getInitParam();
         if(initParam == null)
         {
            return false;
         }
         return initParam.grouped;
      }
      
      public function getGroup() : int
      {
         return getInitParam().group;
      }
   }
}

