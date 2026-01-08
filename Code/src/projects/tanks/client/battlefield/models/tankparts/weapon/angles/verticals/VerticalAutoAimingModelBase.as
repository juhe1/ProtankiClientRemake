package projects.tanks.client.battlefield.models.tankparts.weapon.angles.verticals
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class VerticalAutoAimingModelBase extends Model
   {

      protected var server:VerticalAutoAimingModelServer;

      private static const modelId:Long = Long.getLong(504614809,-1413592676);

      public function VerticalAutoAimingModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new VerticalAutoAimingModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
