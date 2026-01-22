package projects.tanks.client.tanksservices.model.listener
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class UserNotifierModelBase extends Model
   {

      protected var server:UserNotifierModelServer;

      public static const modelId:Long = Long.getLong(1490830385,-2144376380);

      public function UserNotifierModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new UserNotifierModelServer(IModel(this));
      }

      protected function getInitParam() : UserNotifierCC
      {
         return UserNotifierCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
