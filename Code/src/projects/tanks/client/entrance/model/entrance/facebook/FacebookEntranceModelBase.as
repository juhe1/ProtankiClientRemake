package projects.tanks.client.entrance.model.entrance.facebook
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class FacebookEntranceModelBase extends Model
   {

      protected var server:FacebookEntranceModelServer;

      public static const modelId:Long = Long.getLong(173156618,-1197639698);

      public function FacebookEntranceModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new FacebookEntranceModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
