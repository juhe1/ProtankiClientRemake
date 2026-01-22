package projects.tanks.client.users.model.friends.acceptednotificator
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   import projects.tanks.client.users.model.friends.container.UserContainerCC;

   public class FriendsAcceptedNotificatorModelBase extends Model
   {

      protected var server:FriendsAcceptedNotificatorModelServer;

      public static const modelId:Long = Long.getLong(100897389,708983546);

      public function FriendsAcceptedNotificatorModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new FriendsAcceptedNotificatorModelServer(IModel(this));
      }

      protected function getInitParam() : UserContainerCC
      {
         return UserContainerCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
