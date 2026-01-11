package scpacker.networking.protocol.packets.battle
{
   import projects.tanks.client.battlefield.types.Vector3d;
   import scpacker.networking.protocol.AbstractPacket;
   
   public class AddBonusBoxInPacket extends AbstractPacket
   {
      public static const id:int = 1831462385;
      
      public var bonusId:String;
      
      public var position:Vector3d;
      
      public var fallTimeThreshold:int;
      
      public function AddBonusBoxInPacket(param1:String = "", param2:Vector3d = null, param3:int = 0)
      {
         super();
         this.bonusId = param1;
         this.position = param2;
         this.fallTimeThreshold = param3;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
         registerProperty(param2);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.CodecVector3d");
         registerProperty(param3);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.bonusId = param1 as String;
               break;
            case 1:
               this.position = param1 as Vector3d;
               break;
            case 2:
               this.fallTimeThreshold = param1 as int;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new AddBonusBoxInPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 36;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}

