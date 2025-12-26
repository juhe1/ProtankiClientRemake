package projects.tanks.client.entrance.model.entrance.email
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
   
   public class EmailRegistrationModelServer
   {
      private var model:IModel;
      
      public function EmailRegistrationModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }
      
      public function checkEmail(param1:String) : void
      {
      }
      
      public function registerUserRequiredEmail(param1:String, param2:String, param3:String, param4:String, param5:String, param6:String) : void
      {
      }
   }
}

