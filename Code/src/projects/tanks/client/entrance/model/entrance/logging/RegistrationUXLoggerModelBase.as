package projects.tanks.client.entrance.model.entrance.logging
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class RegistrationUXLoggerModelBase extends Model
   {

      protected var server:RegistrationUXLoggerModelServer;

      public static const modelId:Long = Long.getLong(1494230661,807116609);

      public function RegistrationUXLoggerModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new RegistrationUXLoggerModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
