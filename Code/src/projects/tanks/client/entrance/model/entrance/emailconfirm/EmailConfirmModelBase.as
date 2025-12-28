package projects.tanks.client.entrance.model.entrance.emailconfirm
{
   import alternativa.osgi.OSGi;
   import alternativa.protocol.IProtocol;
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   
   public class EmailConfirmModelBase extends Model
   {
      
      private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));
      
      protected var server:EmailConfirmModelServer;
      
      private var client:IEmailConfirmModelBase = IEmailConfirmModelBase(this);
      
      public static var modelId:Long = Long.getLong(284901932,-278416008);
      
      public function EmailConfirmModelBase()
      {
         super();
         this.initCodecs();
      }
      
      protected function initCodecs() : void
      {
         this.server = new EmailConfirmModelServer(IModel(this));
      }
      
      
      override public function get id() : Long
      {
         return modelId;
      }
   }
}

