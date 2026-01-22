package projects.tanks.client.tanksservices.model.logging
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class UserActionsLoggerModelBase extends Model
   {

      protected var server:UserActionsLoggerModelServer;

      public static const modelId:Long = Long.getLong(430855235,-1931735028);

      public function UserActionsLoggerModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new UserActionsLoggerModelServer(IModel(this));
      }

      protected function getInitParam() : UserActionsLoggerCC
      {
         return UserActionsLoggerCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
