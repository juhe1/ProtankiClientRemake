package projects.tanks.client.commons.models.layout
{
   import platform.client.fp10.core.model.IModel;
   import scpacker.networking.Network;
   import alternativa.osgi.OSGi;
   import scpacker.networking.protocol.packets.clientlayout.LoadGarage;
   import scpacker.networking.protocol.packets.clientlayout.LoadLobby;
   
   public class LobbyLayoutModelServer
   {  
      private var model:IModel;
      private var network:Network = OSGi.getInstance().getService(Network) as Network;
      
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
         network.send(new LoadLobby());
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
         network.send(new LoadGarage());
      }
      
      public function showMatchmaking() : void
      {
      }
   }
}

