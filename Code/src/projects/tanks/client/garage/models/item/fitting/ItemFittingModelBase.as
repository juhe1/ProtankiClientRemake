package projects.tanks.client.garage.models.item.fitting
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   import projects.tanks.client.garage.models.item.fitting.ItemFittingModelServer;
   
   public class ItemFittingModelBase extends Model
   {
      public static const modelId:Long = Long.getLong(882584998,678334280);
      
      protected var server:ItemFittingModelServer;
      
      public function ItemFittingModelBase()
      {
         super();
         this.server = new ItemFittingModelServer(IModel(this));
      }
      
      override public function get id() : Long
      {
         return modelId;
      }
   }
}

