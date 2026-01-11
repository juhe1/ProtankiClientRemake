package projects.tanks.client.battlefield.models.anticheat.timechecker
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class TimeCheckerModelBase extends Model
   {

      protected var server:TimeCheckerModelServer;

      public static const modelId:Long = Long.getLong(747925004,799189270);

      public function TimeCheckerModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new TimeCheckerModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
