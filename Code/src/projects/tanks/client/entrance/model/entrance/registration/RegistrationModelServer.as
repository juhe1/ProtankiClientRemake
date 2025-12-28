package projects.tanks.client.entrance.model.entrance.registration
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import scpacker.networking.Network;
   import alternativa.osgi.OSGi;
   import scpacker.networking.protocol.packets.registration.CheckNameAvailabilityOutPacket;
   import scpacker.networking.protocol.packets.registration.CreateAccountOutPacket;
   
   public class RegistrationModelServer
   {
      private var model:IModel;

      private var network:Network = Network(OSGi.getInstance().getService(Network));
      
      public function RegistrationModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }
      
      public function checkUid(param1:String) : void
      {
         network.send(new CheckNameAvailabilityOutPacket(param1));
      }
      
      public function register(param1:String, param2:String, param3:String, param4:Boolean, param5:String, param6:String, param7:String) : void
      {
         network.send(new CreateAccountOutPacket(param1, param2, param4));
      }
      
      public function setFormerUserId(param1:Long) : void
      {
        
      }
   }
}

