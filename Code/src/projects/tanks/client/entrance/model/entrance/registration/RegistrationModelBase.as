package projects.tanks.client.entrance.model.entrance.registration
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class RegistrationModelBase extends Model
   {

      protected var server:RegistrationModelServer;

      public static const modelId:Long = Long.getLong(576129845,453074872);

      public function RegistrationModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new RegistrationModelServer(IModel(this));
      }

      protected function getInitParam() : RegistrationModelCC
      {
         return RegistrationModelCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
