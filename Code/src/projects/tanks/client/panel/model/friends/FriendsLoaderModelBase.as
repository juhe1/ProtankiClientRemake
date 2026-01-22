package projects.tanks.client.panel.model.friends
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class FriendsLoaderModelBase extends Model
   {

      protected var server:FriendsLoaderModelServer;

      public static const modelId:Long = Long.getLong(1511905518,2017080539);

      public function FriendsLoaderModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new FriendsLoaderModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
