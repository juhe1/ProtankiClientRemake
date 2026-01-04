package alternativa.tanks.model.item.fitting
{
   import projects.tanks.client.garage.models.item.fitting.IItemFittingModelBase;
   import projects.tanks.client.garage.models.item.fitting.ItemFittingModelBase;
   import platform.client.fp10.core.model.impl.Model;
   
   [ModelInfo]
   public class ItemFittingModel extends ItemFittingModelBase implements IItemFittingModelBase, ItemFitting
   {
      
      public function ItemFittingModel()
      {
         super();
      }
      
      public function fit() : void
      {
         server.fit(Model.object.name);
      }
   }
}

