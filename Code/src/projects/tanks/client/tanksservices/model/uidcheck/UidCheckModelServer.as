package projects.tanks.client.tanksservices.model.uidcheck
{
   import platform.client.fp10.core.model.IModel;
   
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

