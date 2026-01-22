package scpacker.networking.protocol.packets.shaft
{
   import projects.tanks.client.battlefield.types.Vector3d;
   import scpacker.networking.protocol.AbstractPacket;
   
   public class ShaftLaserAimAtTankOutPacket extends AbstractPacket
   {
      public static const id:int = -1517837003;
      
      public var targetTank:String;
      
      public var localSpotPosition:Vector3d;
      
      public function ShaftLaserAimAtTankOutPacket(param1:String = "", param2:Vector3d = null)
      {
         super();
         this.targetTank = param1;
         this.localSpotPosition = param2;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
         registerProperty(param2);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.CodecVector3d");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.targetTank = param1 as String;
               break;
            case 1:
               this.localSpotPosition = param1 as Vector3d;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new ShaftLaserAimAtTankOutPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 50;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}

