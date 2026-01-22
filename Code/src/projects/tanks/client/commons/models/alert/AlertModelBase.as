package projects.tanks.client.commons.models.alert
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class AlertModelBase extends Model
   {

      protected var server:AlertModelServer;

      public static const modelId:Long = Long.getLong(2058573415,-746879275);

      public function AlertModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new AlertModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
