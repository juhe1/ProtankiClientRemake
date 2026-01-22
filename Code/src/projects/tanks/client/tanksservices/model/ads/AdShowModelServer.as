package projects.tanks.client.tanksservices.model.ads
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;

   public class AdShowModelServer
   {

      private var model:IModel;

      public function AdShowModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function logAdShow(param1:Number, param2:String, param3:String) : void
      {
      }
   }
}
