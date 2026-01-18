package scpacker.networking.protocol.packets.capturetheflag
{
   import scpacker.networking.protocol.AbstractPacket;
   import projects.tanks.client.battlefield.models.battle.ctf.CaptureTheFlagCC;
   
   public class LoadCaptureTheFlagCCInPacket extends AbstractPacket
   {
      public static const id:int = 789790814;
      
      public var cc:CaptureTheFlagCC;
      
      public function LoadCaptureTheFlagCCInPacket(param1:CaptureTheFlagCC = null)
      {
         super();
         this.cc = param1;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.CodecCaptureTheFlagCC");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.cc = param1 as CaptureTheFlagCC;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new LoadCaptureTheFlagCCInPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 42;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}
