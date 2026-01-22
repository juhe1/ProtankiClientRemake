package projects.tanks.client.entrance.model.entrance.trackingshower
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class TrackingPixelShowingModelBase extends Model
   {

      protected var server:TrackingPixelShowingModelServer;

      public static const modelId:Long = Long.getLong(1856211401,2131898451);

      public function TrackingPixelShowingModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new TrackingPixelShowingModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
