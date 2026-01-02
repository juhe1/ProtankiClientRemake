package projects.tanks.client.garage.models.garage
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;
   
   public class GarageModelServer
   {
      private var model:IModel;
      
      public function GarageModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }
      
      public function itemBought(param1:IGameObject, param2:int, param3:int) : void
      {
      }
      
      public function itemMounted(param1:IGameObject) : void
      {
      }
      
      public function itemUnmounted(param1:IGameObject) : void
      {
      }
      
      public function kitBought(param1:IGameObject, param2:int) : void
      {
      }
      
      public function readyToReload() : void
      {
      }
   }
}

