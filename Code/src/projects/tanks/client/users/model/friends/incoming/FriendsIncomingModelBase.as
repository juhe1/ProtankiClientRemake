package projects.tanks.client.users.model.friends.incoming
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   import projects.tanks.client.users.model.friends.container.UserContainerCC;

   public class FriendsIncomingModelBase extends Model
   {

      protected var server:FriendsIncomingModelServer;

      public static const modelId:Long = Long.getLong(1552139010,1361964288);

      public function FriendsIncomingModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new FriendsIncomingModelServer(IModel(this));
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
