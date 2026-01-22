package projects.tanks.client.commons.models.externalauth
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;

   public class ExternalAuthApiModelServer
   {

      private var model:IModel;

      public function ExternalAuthApiModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function authorize(param1:String, param2:ExternalAuthParameters) : void
      {
      }
   }
}
