package projects.tanks.client.panel.model.dailyquest
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import scpacker.networking.Network;
   import alternativa.osgi.OSGi;
   import scpacker.networking.protocol.packets.missions.SkipQuestForCrystalsOutPacket;
   import scpacker.networking.protocol.packets.missions.SkipQuestForFreeOutPacket;
   import scpacker.networking.protocol.packets.missions.TakePrizeOutPacket;
   
   public class DailyQuestModelServer
   {
      private var model:IModel;
      private var network:Network = Network(OSGi.getInstance().getService(Network));
      
      public function DailyQuestModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }
      
      public function skipQuestForCrystals(param1:Long, param2:int) : void
      {
         network.send(new SkipQuestForCrystalsOutPacket(param1.low));
      }
      
      public function skipQuestForFree(param1:Long) : void
      {
         network.send(new SkipQuestForFreeOutPacket(param1.low));
      }
      
      public function takePrize(param1:Long) : void
      {
         network.send(new TakePrizeOutPacket(param1.low));
      }
   }
}

