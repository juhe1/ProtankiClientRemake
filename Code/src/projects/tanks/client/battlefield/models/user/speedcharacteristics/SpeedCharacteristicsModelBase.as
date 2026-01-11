package projects.tanks.client.battlefield.models.user.speedcharacteristics
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class SpeedCharacteristicsModelBase extends Model
   {

      protected var server:SpeedCharacteristicsModelServer;

      public static const modelId:Long = Long.getLong(1667805908,-902263720);

      public function SpeedCharacteristicsModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new SpeedCharacteristicsModelServer(IModel(this));
      }

      protected function getInitParam() : SpeedCharacteristicsCC
      {
         return SpeedCharacteristicsCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
