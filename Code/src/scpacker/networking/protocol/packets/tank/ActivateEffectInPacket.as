package scpacker.networking.protocol.packets.tank
{
   import scpacker.networking.protocol.AbstractPacket;
   
   public class ActivateEffectInPacket extends AbstractPacket
   {
      public static const id:int = -1639713644;

      public var tankId:String;
      
      public var effectId:int;
      
      public var duration:int;
      
      public var activeAfterDeath:Boolean;
      
      public var effectLevel:int;
      
      public function ActivateEffectInPacket(param1:String = "", param2:int = 0, param3:int = 0, param4:Boolean = false, param5:int = 0)
      {
         super();
         this.tankId = param1;
         this.effectId = param2;
         this.duration = param3;
         this.activeAfterDeath = param4;
         this.effectLevel = param5;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
         registerProperty(param2);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
         registerProperty(param3);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
         registerProperty(param4);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.BooleanCodec");
         registerProperty(param5);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.ByteCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.tankId = param1 as String;
               break;
            case 1:
               this.effectId = param1 as int;
               break;
            case 2:
               this.duration = param1 as int;
               break;
            case 3:
               this.activeAfterDeath = param1 as Boolean;
               break;
            case 4:
               this.effectLevel = param1 as int;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new ActivateEffectInPacket();
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

