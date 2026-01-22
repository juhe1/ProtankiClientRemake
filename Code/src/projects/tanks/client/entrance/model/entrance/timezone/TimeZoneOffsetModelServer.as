package projects.tanks.client.entrance.model.entrance.timezone
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;

   public class TimeZoneOffsetModelServer
   {

      private var model:IModel;

      public function TimeZoneOffsetModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function setZoneOffset(param1:String) : void
      {
      }
   }
}
