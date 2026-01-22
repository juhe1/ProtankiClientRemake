package projects.tanks.client.entrance.model.entrance.changeuid
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;

   public class ChangeUidModelServer
   {

      private var model:IModel;

      public function ChangeUidModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function changeUid(param1:String, param2:String, param3:String) : void
      {
      }

      public function changeUidAndPassword(param1:String, param2:String, param3:String, param4:String) : void
      {
      }

      public function changeUidViaPartner(param1:String) : void
      {
      }

      public function checkChangeUidParams(param1:String, param2:String) : void
      {
      }
   }
}
