package scpacker.networking.protocol.packets.smoky
{
   import projects.tanks.client.battlefield.types.Vector3d;
   import scpacker.networking.protocol.AbstractPacket;
   
   public class SmokyShootTargetInPacket extends AbstractPacket
   {
      public static const id:int = -1334002026;
      
      public var shooter:String;
      
      public var target:String;
      
      public var hitPoint:Vector3d;
      
      public var weakeningCoeff:Number;
      
      public var isCritical:Boolean;
      
      public function SmokyShootTargetInPacket(param1:String = "", param2:String = "", param3:Vector3d = null, param4:Number = 0, param5:Boolean = false)
      {
         super();
         this.shooter = param1;
         this.target = param2;
         this.hitPoint = param3;
         this.weakeningCoeff = param4;
         this.isCritical = param5;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
         registerProperty(param2);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
         registerProperty(param3);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.CodecVector3d");
         registerProperty(param4);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.FloatCodec");
         registerProperty(param5);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.BooleanCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.shooter = param1 as String;
               break;
            case 1:
               this.target = param1 as String;
               break;
            case 2:
               this.hitPoint = param1 as Vector3d;
               break;
            case 3:
               this.weakeningCoeff = param1 as Number;
               break;
            case 4:
               this.isCritical = param1 as Boolean;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new SmokyShootTargetInPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 49;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}

