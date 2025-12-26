package projects.tanks.client.entrance.model.entrance.registration
{
   import alternativa.osgi.OSGi;
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.OptionalMap;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.protocol.info.TypeCodecInfo;
   import alternativa.types.Long;
   import flash.utils.ByteArray;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   import platform.client.fp10.core.network.command.SpaceCommand;
   import platform.client.fp10.core.type.IGameObject;
   import platform.client.fp10.core.type.ISpace;
   
   public class RegistrationModelServer
   {
      private var model:IModel;
      
      public function RegistrationModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }
      
      public function checkUid(param1:String) : void
      {
       
      }
      
      public function register(param1:String, param2:String, param3:String, param4:Boolean, param5:String, param6:String, param7:String) : void
      {
       
      }
      
      public function setFormerUserId(param1:Long) : void
      {
        
      }
   }
}

