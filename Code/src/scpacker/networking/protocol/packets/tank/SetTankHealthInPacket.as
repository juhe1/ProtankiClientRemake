package scpacker.networking.protocol.packets.tank
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class SetTankHealthInPacket extends AbstractPacket
   {
      public static const id:int = -611961116;

      public var tankId:String;
      
      public var health:Number;
      
      public function SetTankHealthInPacket(param1:String = "", param2:Number = 0)
      {
         super();
         this.tankId = param1;
         this.health = param2;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
         registerProperty(param2);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.FloatCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.tankId = param1 as String;
               break;
            case 1:
               this.health = param1 as Number;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new SetTankHealthInPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 39;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}

