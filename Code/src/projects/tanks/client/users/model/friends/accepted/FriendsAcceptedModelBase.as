package projects.tanks.client.users.model.friends.accepted
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   import projects.tanks.client.users.model.friends.container.UserContainerCC;

   public class FriendsAcceptedModelBase extends Model
   {

      protected var server:FriendsAcceptedModelServer;

      public static const modelId:Long = Long.getLong(1696580544,685225790);

      public function FriendsAcceptedModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new FriendsAcceptedModelServer(IModel(this));
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
