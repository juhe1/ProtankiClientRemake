package scpacker.networking.protocol.packets.controlpoints
{
   import projects.tanks.client.battlefield.models.battle.cp.ControlPointsCC;
   import scpacker.networking.protocol.AbstractPacket;
   
   public class LoadControlPointsCCInPacket extends AbstractPacket
   {
      public static const id:int = -1337059439;
      
      public var soundNotification:ControlPointsCC;
      
      public function LoadControlPointsCCInPacket(param1:ControlPointsCC = null)
      {
         super();
         this.soundNotification = param1;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.CodecControlPointsCC");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.soundNotification = param1 as ControlPointsCC;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new LoadControlPointsCCInPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 60;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}

