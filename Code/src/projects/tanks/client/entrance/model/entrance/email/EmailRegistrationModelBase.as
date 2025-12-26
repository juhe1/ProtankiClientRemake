package projects.tanks.client.entrance.model.entrance.email
{
   import alternativa.osgi.OSGi;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   
   public class EmailRegistrationModelBase extends Model
   {
      protected var server:EmailRegistrationModelServer = new EmailRegistrationModelServer(this);
      
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

