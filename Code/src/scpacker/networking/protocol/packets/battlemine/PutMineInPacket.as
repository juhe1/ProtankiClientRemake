package scpacker.networking.protocol.packets.battlemine
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class PutMineInPacket extends AbstractPacket
   {
      public static const id:int = 272183855;
      
      public var mineId:String;
      
      public var x:Number;
      
      public var y:Number;
      
      public var z:Number;
      
      public var userId:String;
      
      public function PutMineInPacket(param1:String = "", param2:Number = 0, param3:Number = 0, param4:Number = 0, param5:String = "")
      {
         super();
         this.mineId = param1;
         this.x = param2;
         this.y = param3;
         this.z = param4;
         this.userId = param5;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
         registerProperty(param2);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.FloatCodec");
         registerProperty(param3);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.FloatCodec");
         registerProperty(param4);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.FloatCodec");
         registerProperty(param5);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.mineId = param1 as String;
               break;
            case 1:
               this.x = param1 as Number;
               break;
            case 2:
               this.y = param1 as Number;
               break;
            case 3:
               this.z = param1 as Number;
               break;
            case 4:
               this.userId = param1 as String;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new PutMineInPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 62;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}

