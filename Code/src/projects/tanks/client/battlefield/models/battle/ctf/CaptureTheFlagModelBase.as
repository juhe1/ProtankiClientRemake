package projects.tanks.client.battlefield.models.battle.ctf
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class CaptureTheFlagModelBase extends Model
   {

      protected var server:CaptureTheFlagModelServer;

      public static const modelId:Long = Long.getLong(1965338956,1417730743);

      public function CaptureTheFlagModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new CaptureTheFlagModelServer(IModel(this));
      }

      protected function getInitParam() : CaptureTheFlagCC
      {
         return CaptureTheFlagCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
