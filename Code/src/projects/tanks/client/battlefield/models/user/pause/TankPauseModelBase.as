package projects.tanks.client.battlefield.models.user.pause
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class TankPauseModelBase extends Model
   {

      protected var server:TankPauseModelServer;

      private static const modelId:Long = Long.getLong(1396750689,-217255698);

      public function TankPauseModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new TankPauseModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
