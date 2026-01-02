package projects.tanks.client.garage.models.item.item3d
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   import projects.tanks.client.garage.models.item.item3d.Item3DCC;
   import projects.tanks.client.garage.models.item.item3d.Item3DModelServer;
   
   public class Item3DModelBase extends Model
   {
      public static const modelId:Long = Long.getLong(1739715120,-17857031);
      
      protected var server:Item3DModelServer;
      
      public function Item3DModelBase()
      {
         super();
         this.server = new Item3DModelServer(IModel(this));
      }
      
      protected function getInitParam() : Item3DCC
      {
         return Item3DCC(initParams[Model.object]);
      }
      
      override public function get id() : Long
      {
         return modelId;
      }
   }
}

