package projects.tanks.client.battlefield.models.tankparts.sfx.smoke
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class HullSmokeModelBase extends Model
   {

      protected var server:HullSmokeModelServer;

      public static const modelId:Long = Long.getLong(1546360680,1128943603);

      public function HullSmokeModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new HullSmokeModelServer(IModel(this));
      }

      protected function getInitParam() : HullSmokeCC
      {
         return HullSmokeCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
