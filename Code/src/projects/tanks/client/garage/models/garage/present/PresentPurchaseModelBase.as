package projects.tanks.client.garage.models.garage.present
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   import projects.tanks.client.garage.models.garage.present.PresentPurchaseModelServer;
   
   public class PresentPurchaseModelBase extends Model
   {
      public static const modelId:Long = Long.getLong(888433053,2115284408);
      
      protected var server:PresentPurchaseModelServer;
      
      public function PresentPurchaseModelBase()
      {
         super();
         this.server = new PresentPurchaseModelServer(IModel(this));
      }
      
      override public function get id() : Long
      {
         return modelId;
      }
   }
}

