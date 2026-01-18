package scpacker.networking.protocol.packets.controlpoints
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class SetPointProgressInPacket extends AbstractPacket
   {
      public static const id:int = -2141998253;
      
      public var pointId:int;
      
      public var progress:Number;
      
      public var progressSpeed:Number;
      
      public function SetPointProgressInPacket(param1:int = 0, param2:Number = 0, param3:Number = 0)
      {
         super();
         this.pointId = param1;
         this.progress = param2;
         this.progressSpeed = param3;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
         registerProperty(param2);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.FloatCodec");
         registerProperty(param3);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.FloatCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.pointId = param1 as int;
               break;
            case 1:
               this.progress = param1 as Number;
               break;
            case 2:
               this.progressSpeed = param1 as Number;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new SetPointProgressInPacket();
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

