package projects.tanks.client.users.model.friends
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class FriendsModelBase extends Model
   {

      protected var server:FriendsModelServer;

      public static const modelId:Long = Long.getLong(1693173045,628784534);

      public function FriendsModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new FriendsModelServer(IModel(this));
      }

      protected function getInitParam() : FriendsCC
      {
         return FriendsCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
