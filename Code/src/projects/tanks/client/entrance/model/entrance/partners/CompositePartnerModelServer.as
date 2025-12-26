package projects.tanks.client.entrance.model.entrance.partners
{
   import alternativa.osgi.OSGi;
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.OptionalMap;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.protocol.info.TypeCodecInfo;
   import alternativa.types.Long;
   import flash.utils.ByteArray;
   import platform.client.core.general.socialnetwork.types.LoginParameters;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   import platform.client.fp10.core.network.command.SpaceCommand;
   import platform.client.fp10.core.type.IGameObject;
   import platform.client.fp10.core.type.ISpace;
   
   public class CompositePartnerModelServer
   {
      private var model:IModel;
      
      public function CompositePartnerModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }
      
      public function bindAccount(param1:String, param2:String) : void
      {
      }
      
      public function finishRegistration(param1:String, param2:String) : void
      {
      }
      
      public function loadPartnerObjectOnClient(param1:String) : void
      {
      }
      
      public function loginViaPartner(param1:String, param2:LoginParameters) : void
      {
      }
   }
}

