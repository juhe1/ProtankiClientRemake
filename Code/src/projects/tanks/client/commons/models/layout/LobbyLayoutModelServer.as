package projects.tanks.client.commons.models.layout
{
   import alternativa.osgi.OSGi;
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.OptionalMap;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.protocol.info.EnumCodecInfo;
   import alternativa.protocol.info.TypeCodecInfo;
   import alternativa.types.Long;
   import flash.utils.ByteArray;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   import platform.client.fp10.core.network.command.SpaceCommand;
   import platform.client.fp10.core.type.IGameObject;
   import platform.client.fp10.core.type.ISpace;
   
   public class LobbyLayoutModelServer
   {  
      private var model:IModel;
      
      public function LobbyLayoutModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }
      
      public function exitFromBattle(param1:LayoutState) : void
      {
      }
      
      public function exitFromBattleToBattleLobby() : void
      {
      }
      
      public function returnToBattle() : void
      {
      }
      
      public function setBattleLobbyLayout(param1:Boolean) : void
      {
      }
      
      public function showBattleSelect() : void
      {
      }
      
      public function showClan() : void
      {
      }
      
      public function showGarage() : void
      {
      }
      
      public function showMatchmaking() : void
      {
      }
   }
}

