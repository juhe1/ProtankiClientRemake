package scpacker.networking.protocol.packets.shaft
{
   import projects.tanks.client.battlefield.types.Vector3d;
   import scpacker.networking.protocol.AbstractPacket;
   
   public class ShaftLaserAimAtTankInPacket extends AbstractPacket
   {
      public static const id:int = 11992250;
      
      public var shooterId:String;
      
      public var targetTank:String;
      
      public var localSpotPosition:Vector3d;
      
      public function ShaftLaserAimAtTankInPacket(param1:String = "", param2:String = "", param3:Vector3d = null)
      {
         super();
         this.shooterId = param1;
         this.targetTank = param2;
         this.localSpotPosition = param3;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
         registerProperty(param2);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
         registerProperty(param3);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.CodecVector3d");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.shooterId = param1 as String;
               break;
            case 1:
               this.targetTank = param1 as String;
               break;
            case 2:
               this.localSpotPosition = param1 as Vector3d;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new ShaftLaserAimAtTankInPacket();
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

