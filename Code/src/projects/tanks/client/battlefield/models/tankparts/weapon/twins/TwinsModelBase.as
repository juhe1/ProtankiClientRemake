package projects.tanks.client.battlefield.models.tankparts.weapon.twins
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class TwinsModelBase extends Model
   {

      protected var server:TwinsModelServer;

      public static const modelId:Long = Long.getLong(1952266263,-1912192267);

      public function TwinsModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new TwinsModelServer(IModel(this));
      }

      protected function getInitParam() : TwinsCC
      {
         return TwinsCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
