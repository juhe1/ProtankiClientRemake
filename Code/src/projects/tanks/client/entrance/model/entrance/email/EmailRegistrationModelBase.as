package projects.tanks.client.entrance.model.entrance.email
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.impl.Model;
   import platform.client.fp10.core.model.IModel;
   
   public class EmailRegistrationModelBase extends Model
   {
      protected var server:EmailRegistrationModelServer = new EmailRegistrationModelServer(IModel(this));
      
      private var client:IEmailRegistrationModelBase = IEmailRegistrationModelBase(this);
      
      static public var modelId:Long = Long.getLong(674978907,-800007187);

      public function EmailRegistrationModelBase()
      {
         super();
      }
      
      override public function get id() : Long
      {
         return modelId;
      }
   }
}

