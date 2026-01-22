package projects.tanks.client.commons.models.detach
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;

   public class DetachModelServer
   {

      private var model:IModel;

      public function DetachModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function detach() : void
      {
      }
   }
}
