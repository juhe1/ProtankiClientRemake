package projects.tanks.client.entrance.model.entrance.externalentrance
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
   
   public class ExternalEntranceModelServer
   {

      private var model:IModel;
      
      public function ExternalEntranceModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }
      
      public function createLinkForExistingUser(param1:String, param2:String) : void
      {
      }
      
      public function registerNewUser(param1:String, param2:String) : void
      {
      }
      
      public function setLoginData(param1:Boolean, param2:String) : void
      {
      }
   }
}

