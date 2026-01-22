package projects.tanks.client.entrance.model.entrance.email
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class EmailRegistrationModelBase extends Model
   {

      protected var server:EmailRegistrationModelServer;

      public static const modelId:Long = Long.getLong(674978907,-800007187);

      public function EmailRegistrationModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new EmailRegistrationModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
