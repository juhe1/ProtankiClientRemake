package projects.tanks.client.users.model.friends.incomingnotificator
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   import projects.tanks.client.users.model.friends.container.UserContainerCC;

   public class FriendsIncomingNotificatorModelBase extends Model
   {

      protected var server:FriendsIncomingNotificatorModelServer;

      public static const modelId:Long = Long.getLong(1435596993,-649634714);

      public function FriendsIncomingNotificatorModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new FriendsIncomingNotificatorModelServer(IModel(this));
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
