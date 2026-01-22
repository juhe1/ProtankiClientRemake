package projects.tanks.client.commons.models.gpu
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;

   public class GPUDetectorModelServer
   {

      private var model:IModel;

      public function GPUDetectorModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function detectionGPUcompleted(param1:Boolean) : void
      {
      }
   }
}
