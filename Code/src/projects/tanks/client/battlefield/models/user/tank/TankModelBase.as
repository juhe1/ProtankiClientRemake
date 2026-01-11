package projects.tanks.client.battlefield.models.user.tank
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class TankModelBase extends Model
   {

      protected var server:TankModelServer;

      public static const modelId:Long = Long.getLong(500772743,-1275562344);

      public function TankModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new TankModelServer(IModel(this));
      }

      protected function getInitParam() : TankCC
      {
         return TankCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
