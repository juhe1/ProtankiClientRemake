package projects.tanks.client.commons.models.layout.notify
{
   import alternativa.osgi.OSGi;
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.protocol.info.EnumCodecInfo;
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   import projects.tanks.client.commons.models.layout.LayoutState;
   
   public class LobbyLayoutNotifyModelBase extends Model
   {
      
      protected var server:LobbyLayoutNotifyModelServer;
      
      private var client:ILobbyLayoutNotifyModelBase = ILobbyLayoutNotifyModelBase(this);
      
      static public var modelId:Long = Long.getLong(1481647778,-291699533);
      
      public function LobbyLayoutNotifyModelBase()
      {
         super();
      }
      
      override public function get id() : Long
      {
         return LobbyLayoutNotifyModelBase.modelId;
      }
   }
}

