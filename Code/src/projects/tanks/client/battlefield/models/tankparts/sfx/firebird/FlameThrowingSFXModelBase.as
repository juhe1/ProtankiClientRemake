package projects.tanks.client.battlefield.models.tankparts.sfx.firebird
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class FlameThrowingSFXModelBase extends Model
   {

      protected var server:FlameThrowingSFXModelServer;

      private static const modelId:Long = Long.getLong(253811659,1003298843);

      public function FlameThrowingSFXModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new FlameThrowingSFXModelServer(IModel(this));
      }

      protected function getInitParam() : FlameThrowingSFXCC
      {
         return FlameThrowingSFXCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
