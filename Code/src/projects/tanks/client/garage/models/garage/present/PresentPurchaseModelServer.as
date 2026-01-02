package projects.tanks.client.garage.models.garage.present
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;
   
   public class PresentPurchaseModelServer
   {
      private var model:IModel;
      
      public function PresentPurchaseModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }
      
      public function checkUid(param1:String) : void
      {
      }
      
      public function purchasePresent(param1:String, param2:IGameObject, param3:String, param4:int) : void
      {
      }
   }
}

