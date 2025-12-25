package scpacker.networking.protocol
{
   import flash.utils.Dictionary;
   
   public class PacketFactory
   {
      private var packets:Dictionary = new Dictionary();
      
      public function PacketFactory()
      {
         super();
      }
      
      public function registerPacket(param1:AbstractPacket) : void
      {
         packets[param1.getId()] = param1;
      }
      
      public function getPacket(param1:int) : AbstractPacket
      {
         return packets[param1];
      }
   }
}

