package projects.tanks.client.panel.model.androidapprating
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class AndroidAppRatingModelBase extends Model
   {

      protected var server:AndroidAppRatingModelServer;

      public static const modelId:Long = Long.getLong(1012815736,604595236);

      public function AndroidAppRatingModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new AndroidAppRatingModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
