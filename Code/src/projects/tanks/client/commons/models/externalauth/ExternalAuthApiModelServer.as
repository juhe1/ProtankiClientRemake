package projects.tanks.client.commons.models.externalauth
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
   
   public class ExternalAuthApiModelServer
   {
      
      private var model:IModel;
      
      public function ExternalAuthApiModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }
      
      public function authorize(param1:String, param2:ExternalAuthParameters) : void
      {
      }
   }
}

