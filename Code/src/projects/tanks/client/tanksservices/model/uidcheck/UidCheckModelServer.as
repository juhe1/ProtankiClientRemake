package projects.tanks.client.tanksservices.model.uidcheck
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;

   public class UidCheckModelServer
   {

      private var model:IModel;

      public function UidCheckModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function validateUid(param1:String) : void
      {
      }
   }
}
