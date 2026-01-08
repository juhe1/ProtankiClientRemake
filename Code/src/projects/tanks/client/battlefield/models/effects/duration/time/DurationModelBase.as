package projects.tanks.client.battlefield.models.effects.duration.time
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class DurationModelBase extends Model
   {

      protected var server:DurationModelServer;

      private static const modelId:Long = Long.getLong(2016151916,-1755051516);

      public function DurationModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new DurationModelServer(IModel(this));
      }

      protected function getInitParam() : DurationCC
      {
         return DurationCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
